
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

    public class GenderController : BaseCRUDController<Gender, BaseSearchObject,GenderUpsertRequest, GenderUpsertRequest>

    {
        public GenderController(ILogger<BaseController<Gender, BaseSearchObject>> logger, IGenderService service) : base(logger, service)
        {
        }
    }
}
