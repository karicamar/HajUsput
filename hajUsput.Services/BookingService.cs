
using AutoMapper;
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services.Database;
using hajUsput.Services.StateMachines;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace hajUsput.Services
{
    public class BookingService : BaseCRUDService<Model.Booking, Database.Booking, BookingSearchObject, BookingInsertRequest, BookingUpdateRequest>, IBookingService
    {

        public BookingService(_180072Context context, IMapper mapper) : base(context, mapper)
        {
           
            
        }
        public void UpdateBookingStatus(int bookingId, BookingStateMachine.BookingTrigger trigger)
        {
            var booking = _context.Bookings.Find(bookingId);
            if (booking == null)
                throw new Exception("Booking not found");

            var bookingStateMachine = new BookingStateMachine((BookingStateMachine.BookingState)Enum.Parse(typeof(BookingStateMachine.BookingState), booking.BookingStatus));

            switch (trigger)
            {
                case BookingStateMachine.BookingTrigger.Confirm:
                    bookingStateMachine.Confirm();
                    break;
                case BookingStateMachine.BookingTrigger.Cancel:
                    bookingStateMachine.Cancel();
                    break;
                case BookingStateMachine.BookingTrigger.Complete:
                    bookingStateMachine.Complete();
                    break;
            }

            booking.BookingStatus = bookingStateMachine.CurrentState.ToString();

            _context.SaveChanges();
        }

        public void ConfirmBooking(int bookingId)
        {
            var booking = _context.Bookings.Find(bookingId);
            if (booking == null)
                throw new Exception("Booking not found");

            
                UpdateBookingStatus(bookingId, BookingStateMachine.BookingTrigger.Confirm);
            

            _context.SaveChanges();
        }
        public void CancelBooking(int bookingId)
        {
            var booking = _context.Bookings.Find(bookingId);
            if (booking == null)
                throw new Exception("Booking not found");


            UpdateBookingStatus(bookingId, BookingStateMachine.BookingTrigger.Cancel);


            _context.SaveChanges();
        }
        public List<Model.Booking> GetUserBookings(int userId)
        {
            var bookings = _context.Bookings
        .Include(b => b.Ride) 
        .Where(b => b.PassengerId == userId || (b.Ride != null && b.Ride.DriverId == userId))
        .ToList();

            return _mapper.Map<List<Model.Booking>>(bookings);
        }
        public List<Model.Booking> GetRideBookings(int rideId)
        {
            var bookings = _context.Bookings
                .Where(b => b.RideId == rideId)
                .ToList();

            return _mapper.Map<List<Model.Booking>>(bookings);
        }
        public Model.Booking GetBookingByRideId(int rideId)
        {
            var booking = _context.Bookings
        .FirstOrDefault(b => b.RideId == rideId);

            if (booking == null)
                throw new Exception("Booking not found");

            return _mapper.Map<Model.Booking>(booking);
        }
    }
}
