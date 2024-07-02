
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services;
using Microsoft.AspNetCore.Mvc;

namespace HajUsput_.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class BookingController : BaseCRUDController<Booking, hajUsput.Model.SearchObjects.BookingSearchObject, hajUsput.Model.Requests.BookingInsertRequest, hajUsput.Model.Requests.BookingUpdateRequest>

    {
        public BookingController(ILogger<BaseController<Booking, hajUsput.Model.SearchObjects.BookingSearchObject>> logger, IBookingService service) : base(logger,service)
        {
            
        }
    }
}
