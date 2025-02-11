
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

    public class CarMakeController : BaseCRUDController<CarMake, CarMakeSearchObject, CarMakeUpsertRequest, CarMakeUpsertRequest>

    {
        private readonly ICarMakeService _carMakeService;

        public CarMakeController(ILogger<BaseController<CarMake, CarMakeSearchObject>> logger, ICarMakeService service) : base(logger, service)
        {
            _carMakeService = service;

        }
    }
}
