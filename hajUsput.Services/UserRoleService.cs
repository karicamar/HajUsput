
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
    public class UserRoleService : BaseCRUDService<Model.UserRole, Database.UserRole, UserRoleSearchObject, UserRoleUpsertRequest, UserRoleUpsertRequest>, IUserRoleService
    {

        public UserRoleService(_180072Context context, IMapper mapper) : base(context, mapper)
        {

        }
        public override IQueryable<Database.UserRole> AddInclude(IQueryable<Database.UserRole> query, UserRoleSearchObject? search = null)
        {
            if (search?.IsRoleIncluded == true)
            {
                query = query.Include("Role");
            }
            return base.AddInclude(query, search);
        }
    }
}
