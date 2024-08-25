
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HajUsput_.Controllers
{
    [ApiController]
    [Route("[controller]")]
    [AllowAnonymous]

    public class GenderController : BaseController<Gender, hajUsput.Model.SearchObjects.BaseSearchObject>

    {
        public GenderController(ILogger<BaseController<Gender, hajUsput.Model.SearchObjects.BaseSearchObject>> logger, IGenderService service) : base(logger,service)
        {
        }
    }
}
