



using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;

namespace hajUsput.Services
{
    public interface IBookingService :  ICRUDService<Booking, BookingSearchObject, BookingInsertRequest, BookingUpdateRequest>

    {
        // Model.User Login(string username, string password);
       



    }
}