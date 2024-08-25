
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services;
using hajUsput.Services.StateMachines;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HajUsput_.Controllers
{
    [ApiController]
    [Route("[controller]")]
    [Authorize(Roles = "User,Admin")]

    public class RideController : BaseCRUDController<Ride, hajUsput.Model.SearchObjects.RideSearchObject, hajUsput.Model.Requests.RideInsertRequest, hajUsput.Model.Requests.RideUpdateRequest>

    {
        private readonly IRideService _rideService;
        public RideController(ILogger<BaseController<Ride, hajUsput.Model.SearchObjects.RideSearchObject>> logger, IRideService service) : base(logger,service)
        {
            _rideService = service;
        }
        [HttpPost("predict")]
        public ActionResult<PredictionResponse> Predict(PredictionRequest request)
        {
            var predictedPrice = _rideService.PredictPrice(request);
            return Ok(new PredictionResponse { Price = predictedPrice });
        }
        [HttpPost("update-status/{rideId}")]
        public IActionResult UpdateRideStatus(int rideId, [FromBody] RideStateMachine.Trigger trigger)
        {
            _rideService.UpdateRideStatus(rideId, trigger);
            return Ok();
        }
        [HttpPost("reduce-seats/{rideId}")]
        public IActionResult ReduceAvailableSeats(int rideId)
        {
            try
            {
                _rideService.ReduceAvailableSeats(rideId);
                return Ok("Seats reduced successfully.");
            }
            catch (Exception ex)
            {
                return BadRequest($"Failed to reduce seats: {ex.Message}");
            }
        }
        [HttpGet("user/{userId}")]
        public IActionResult GetUserRides(int userId)
        {
            var rides = _rideService.GetUserRides(userId);
            return Ok(rides);
        }
        [HttpGet("total-rides")]
        public async Task<int> GetTotalRides()
        {
            var totalRides = await _rideService.GetTotalRidesAsync();
            return totalRides;
        }
        [HttpGet("total-distance")]
        public ActionResult<double> GetTotalDistanceTraveled()
        {
            try
            {
                var totalDistance = _rideService.GetTotalDistanceTraveled();
                return Ok(totalDistance);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpGet("average-distance")]
        public ActionResult<double> GetAverageRideDistance()
        {
            try
            {
                var averageDistance = _rideService.GetAverageRideDistance();
                return Ok(averageDistance);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        // GET: api/Ride/active-rides
        [HttpGet("scheduled-rides")]
        public async Task<int> GetScheduledRides()
        {
            var scheduledRides = await _rideService.GetScheduledRidesAsync();
            return scheduledRides;
        }
        [HttpGet("cancelled-rides")]
        public async Task<int> GetCancelledRides()
        {
            var cancelledRides = await _rideService.GetCancelledRidesAsync();
            return cancelledRides;
        }
        [HttpGet("archived-rides")]
        public async Task<int> GetArchivedRides()
        {
            var archivedRides = await _rideService.GetArchivedRidesAsync();
            return archivedRides;
        }

    }
}
