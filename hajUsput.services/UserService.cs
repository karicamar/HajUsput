
using AutoMapper;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services.Database;
using Microsoft.EntityFrameworkCore;
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

        public UserService(_180072Context context, IMapper mapper) : base(context, mapper)
        {

        }
        public override async Task BeforeInsert(User entity, UserInsertRequest insert)
        {
            entity.PasswordSalt = GenerateSalt();
            entity.PasswordHash = GenerateHash(entity.PasswordSalt, insert.Password);
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

        public override IQueryable<User> AddInclude(IQueryable<User> query, UserSearchObject? search = null)
        {
            if (search?.IsRoleIncluded == true)
            {
                query = query.Include("UserRoles.Role");
            }
            return base.AddInclude(query, search);
        }
        public override IQueryable<User> AddFilter(IQueryable<User> query,UserSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery.Where(x => x.FirstName.Contains(search.FTS) || x.LastName.Contains(search.FTS));
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
        //public async Task<Model.User> Login(string username, string password)
        //{
        //    var entity = await _context.User.Include("KorisniciUloges.Uloga").FirstOrDefaultAsync(x => x.KorisnickoIme == username);

        //    if (entity == null)
        //    {
        //        return null;
        //    }

        //    var hash = GenerateHash(entity.LozinkaSalt, password);

        //    if (hash != entity.LozinkaHash)
        //    {
        //        return null;
        //    }

        //    return _mapper.Map<Model.User>(entity);
        //}
    }
}
