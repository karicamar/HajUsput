
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services;
using hajUsput.Services.StateMachines;
using Microsoft.AspNetCore.Mvc;
using Stripe;

namespace HajUsput.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class BookingController : BaseCRUDController<Booking, BookingSearchObject, BookingInsertRequest, BookingUpdateRequest>

    {
        private readonly IBookingService _bookingService;

        public BookingController(ILogger<BaseController<Booking, BookingSearchObject>> logger, IBookingService service) : base(logger, service)
        {
            _bookingService = service;
        }
        [HttpPost("update-status/{bookingId}")]
        public IActionResult UpdateBookingStatus(int bookingId, [FromBody] BookingStateMachine.BookingTrigger trigger)
        {
            _bookingService.UpdateBookingStatus(bookingId, trigger);
            return Ok();
        }

        [HttpPost("confirm-booking/{bookingId}")]
        public IActionResult ConfirmBooking(int bookingId)
        {
            try
            {
                _bookingService.ConfirmBooking(bookingId);
                return Ok("Booking confirmed successfully.");
            }
            catch (Exception ex)
            {
                return BadRequest($"Failed to confirm booking: {ex.Message}");
            }
        }
        [HttpPost("cancel-booking/{bookingId}")]
        public IActionResult CancelBooking(int bookingId)
        {
            try
            {
                _bookingService.CancelBooking(bookingId);
                return Ok("Booking canceled.");
            }
            catch (Exception ex)
            {
                return BadRequest($"Failed to cancel booking: {ex.Message}");
            }
        }
        [HttpGet("user/{userId}/bookings")]

        public IActionResult GetUserBookings(int userId)
        {
            var bookings = _bookingService.GetUserBookings(userId);
            return Ok(bookings);
        }
        [HttpGet("ride/{rideId}/bookings")]

        public IActionResult GetRideBookings(int rideId)
        {
            var bookings = _bookingService.GetRideBookings(rideId);
            return Ok(bookings);
        }
        [HttpGet("ride/{rideId}")]
        public IActionResult GetBookingByRideId(int rideId)
        {
            try
            {
                var booking = _bookingService.GetBookingByRideId(rideId);
                return Ok(booking);
            }
            catch (Exception ex)
            {
                return NotFound($"Booking not found: {ex.Message}");
            }
        }
    }
}
