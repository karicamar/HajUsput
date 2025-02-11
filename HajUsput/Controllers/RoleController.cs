
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

    public class RoleController : BaseCRUDController<Role, BaseSearchObject,RoleUpsertRequest, RoleUpsertRequest>

    {
        public RoleController(ILogger<BaseController<Role, BaseSearchObject>> logger, IRoleService service) : base(logger, service)
        {
        }
    }
}
