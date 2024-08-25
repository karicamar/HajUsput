
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
    [Authorize(Roles = "User,Admin")]

    public class LocationController : BaseCRUDController<Location, hajUsput.Model.SearchObjects.LocationSearchObject, hajUsput.Model.Requests.LocationInsertRequest, hajUsput.Model.Requests.LocationUpdateRequest>

    {
        private readonly ILocationService _locationService;

        public LocationController(ILogger<BaseController<Location, hajUsput.Model.SearchObjects.LocationSearchObject>> logger, ILocationService service) : base(logger, service)
        {
            _locationService=service;
        }
        

        [HttpPost("checkId")]
        [AllowAnonymous]

        public async Task<IActionResult> CheckId([FromBody] string city)
        {
            if (string.IsNullOrWhiteSpace(city))
            {
                return BadRequest("City name cannot be empty.");
            }

            var locationId = await _locationService.GetLocationIdByCityAsync(city);
            if (locationId == null)
            {
                return NotFound("Location not found.");
            }

            return Ok(locationId);
        }
    }
}
