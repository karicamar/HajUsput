
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services;
using Microsoft.AspNetCore.Mvc;

namespace HajUsput_.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PaymentController : BaseCRUDController<Payment, hajUsput.Model.SearchObjects.BaseSearchObject, hajUsput.Model.Requests.PaymentInsertRequest, hajUsput.Model.Requests.PaymentUpdateRequest>

    {
        public PaymentController(ILogger<BaseController<Payment, hajUsput.Model.SearchObjects.BaseSearchObject>> logger, IPaymentService service) : base(logger,service)
        {
            
        }
    }
}
