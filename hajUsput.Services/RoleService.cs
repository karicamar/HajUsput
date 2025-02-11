
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
    public class RoleService : BaseCRUDService<Model.Role, Database.Role, BaseSearchObject, RoleUpsertRequest, RoleUpsertRequest>, IRoleService
    {

        public RoleService(_180072Context context, IMapper mapper) : base(context, mapper)
        {

        }

        
    }
}
