
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HajUsput.Controllers
{
    [ApiController]
    [Route("[controller]")]
    [AllowAnonymous]

    public class UserRoleController : BaseCRUDController<UserRole, UserRoleSearchObject, UserRoleUpsertRequest, UserRoleUpsertRequest>

    {
        public UserRoleController(ILogger<BaseController<UserRole, UserRoleSearchObject>> logger, IUserRoleService service) : base(logger, service)
        {
        }
    }
}
