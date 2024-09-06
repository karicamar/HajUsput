
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
    [Authorize(Roles = "User,Admin")]

    public class LocationController : BaseCRUDController<Location, LocationSearchObject, LocationInsertRequest, LocationUpdateRequest>

    {
        private readonly ILocationService _locationService;

        public LocationController(ILogger<BaseController<Location, LocationSearchObject>> logger, ILocationService service) : base(logger, service)
        {
            _locationService = service;
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
