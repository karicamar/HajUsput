
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services;
using Microsoft.AspNetCore.Mvc;

namespace HajUsput.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CarController : BaseCRUDController<Car, CarSearchObject, CarInsertRequest, CarUpdateRequest>

    {
        public CarController(ILogger<BaseController<Car, CarSearchObject>> logger, ICarService service) : base(logger, service)
        {
        }
    }
}
