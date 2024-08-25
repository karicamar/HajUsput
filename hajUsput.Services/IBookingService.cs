



using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services.StateMachines;

namespace hajUsput.Services
{
    public interface IBookingService :  ICRUDService<Booking, BookingSearchObject, BookingInsertRequest, BookingUpdateRequest>

    {
       void UpdateBookingStatus(int bookingId, BookingStateMachine.BookingTrigger trigger);

       void ConfirmBooking(int bookingId);
        void CancelBooking(int bookingId);

        public List<Model.Booking> GetUserBookings(int userId);

        public List<Model.Booking> GetRideBookings(int rideId);

        public Booking GetBookingByRideId(int rideId);

    }
}