
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services;
using Microsoft.AspNetCore.Mvc;

namespace HajUsput_.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CarController : BaseCRUDController<Car, hajUsput.Model.SearchObjects.CarSearchObject, hajUsput.Model.Requests.CarInsertRequest, hajUsput.Model.Requests.CarUpdateRequest>

    {
        public CarController(ILogger<BaseController<Car, hajUsput.Model.SearchObjects.CarSearchObject>> logger, ICarService service) : base(logger,service)
        {
        }
    }
}
