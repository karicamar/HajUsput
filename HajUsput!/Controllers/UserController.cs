
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
        
        public UserController(ILogger<BaseController<User, hajUsput.Model.SearchObjects.UserSearchObject>> logger, IUserService service) : base(logger,service)
        {
            
        }
        [HttpPut("Block/{id}")]
        public virtual async Task<User> Block(int id)
        {
            return await (_service as IUserService).Block(id);
        }
    }
}
