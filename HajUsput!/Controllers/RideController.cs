
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services;
using Microsoft.AspNetCore.Mvc;

namespace HajUsput_.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class RideController : BaseCRUDController<Ride, hajUsput.Model.SearchObjects.RideSearchObject, hajUsput.Model.Requests.RideInsertRequest, hajUsput.Model.Requests.RideUpdateRequest>

    {
        public RideController(ILogger<BaseController<Ride, hajUsput.Model.SearchObjects.RideSearchObject>> logger, IRideService service) : base(logger,service)
        {
            
        }
    }
}
