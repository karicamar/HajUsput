
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services;
using Microsoft.AspNetCore.Mvc;

namespace HajUsput_.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : BaseCRUDController<User, hajUsput.Model.SearchObjects.UserSearchObject, hajUsput.Model.Requests.UserInsertRequest, hajUsput.Model.Requests.UserUpdateRequest>

    {
        public UserController(ILogger<BaseController<User, hajUsput.Model.SearchObjects.UserSearchObject>> logger, ICRUDService<User, UserSearchObject, UserInsertRequest, UserUpdateRequest> service) : base(logger,service)
        {
        }
    }
}
