
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
        private readonly ICarService _carService;

        public CarController(ILogger<BaseController<Car, hajUsput.Model.SearchObjects.CarSearchObject>> logger, ICarService service) : base(logger, service)
        {
            _carService = service;

        }
        [HttpGet("user/{userId}")]
        public IActionResult GetCarByUserId(int userId)
        {
            try
            {
                var car = _carService.GetCarsByUserId(userId);
                return Ok(car);
            }
            catch (Exception ex)
            {
                return NotFound($"Car not found: {ex.Message}");
            }
        }
    }
}