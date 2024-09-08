
using AutoMapper;
using Azure.Core;
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services.Database;
using Microsoft.EntityFrameworkCore;
using Stripe.Forwarding;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace hajUsput.Services
{
    public class UserService : BaseCRUDService<Model.User, Database.User, UserSearchObject, UserInsertRequest, UserUpdateRequest>, IUserService
    {
        private readonly RabbitMQProducer _producer;
        public UserService(_180072Context context, IMapper mapper) : base(context, mapper)
        {
            _producer = new RabbitMQProducer();
        }
        public override async Task BeforeInsert(Database.User entity, UserInsertRequest insert)
        {
            entity.PasswordSalt = GenerateSalt();
            entity.PasswordHash = GenerateHash(entity.PasswordSalt, insert.Password);
        }
        public override async Task<Model.User> Insert(UserInsertRequest insert)
        {
            
            var user = await base.Insert(insert);

            // Send a message to RabbitMQ
            var message = $"{insert.Email}|Welcome {insert.Username}! \nYour registration is successful.";
            _producer.SendMessage(message);
            var userRole = new Database.UserRole
            {
                UserId = user.UserId,
                RoleId = 2 // Assuming RoleId 2 corresponds to the "user" role
            };

            _context.UserRoles.Add(userRole);
            await _context.SaveChangesAsync();

            return user;
        }

        public async Task<bool> EmailExists(string email)
        {
            return await _context.Users.AnyAsync(u => u.Email == email);
        }

        public async Task<bool> UsernameExists(string username)
        {
            return await _context.Users.AnyAsync(u => u.Username == username);
        }
        public static string GenerateSalt()
        {
            RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            var byteArray = new byte[16];
            provider.GetBytes(byteArray);


            return Convert.ToBase64String(byteArray);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }

        public override IQueryable<Database.User> AddInclude(IQueryable<Database.User> query, UserSearchObject? search = null)
        {
            if (search?.IsRoleIncluded == true)
            {
                query = query.Include("UserRoles.Role");
            }
            return base.AddInclude(query, search);
        }
        public override IQueryable<Database.User> AddFilter(IQueryable<Database.User> query,UserSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery.Where(x => x.FirstName.Contains(search.FTS) || x.LastName.Contains(search.FTS));
            }
            if (search?.isBlocked.HasValue == true)
            {
                filteredQuery = filteredQuery.Where(x => x.IsBlocked == search.isBlocked.Value);
            }


            return filteredQuery;
        }
        public async Task<Model.User> Login(string username, string password)
        {
            var entity = await _context.Users.Include("UserRoles.Role").FirstOrDefaultAsync(x => x.Username == username);

            if (entity == null)
            {
                return null;
            }

            var hash = GenerateHash(entity.PasswordSalt, password);

            if (hash != entity.PasswordHash)
            {
                return null;
            }

            return _mapper.Map<Model.User>(entity);
        }

        public virtual async Task<Model.User> Block(int id)
        {
            var set = _context.Set<Database.User>();

            var entity = await set.FindAsync(id);
            if (entity.IsBlocked == false) { entity.IsBlocked = true;}
            else {  entity.IsBlocked = false;}
            

            await _context.SaveChangesAsync();
            return _mapper.Map<Model.User>(entity);
        }
        public async Task<Model.Preference> GetPreferences(int userId)
        {
            var entity = await _context.Preferences.FirstOrDefaultAsync(p => p.UserId == userId);
            if (entity == null)
            {
                // Return a default Preference object if no preferences exist
                return new Model.Preference { };
                
                 
                
            }
            return _mapper.Map<Model.Preference>(entity);
        }

        public async Task<Model.Preference> UpdatePreferences(int userId, PreferenceUpsertRequest request)
        {
            var entity = await _context.Preferences.FirstOrDefaultAsync(p => p.UserId == userId);
           
            if (entity == null)
            {
                // No preferences exist, create a new entity and map the request
                entity = _mapper.Map<Database.Preference>(request);
                entity.UserId = userId;
                _context.Preferences.Add(entity);
            }
            else
            {
                // Preferences exist, update the entity with the new values from the request
                _mapper.Map(request, entity);
            }
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Preference>(entity);
        }
        public async Task<bool> ChangePassword(int userId, string oldPassword, string newPassword)
        {
            var user = await _context.Users.FindAsync(userId);

            if (user == null)
            {
                return false;
            }

            var oldHash = GenerateHash(user.PasswordSalt, oldPassword);
            if (oldHash != user.PasswordHash)
            {
                return false;
            }

            user.PasswordSalt = GenerateSalt();
            user.PasswordHash = GenerateHash(user.PasswordSalt, newPassword);

            _context.Users.Update(user);
            await _context.SaveChangesAsync();

            return true;
        }
        public async Task<int> GetTotalUsersAsync()
        {
            return await _context.Users.CountAsync();
        }
    }
}
