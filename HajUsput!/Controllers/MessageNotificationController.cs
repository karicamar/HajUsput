
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services;
using Microsoft.AspNetCore.Mvc;

namespace HajUsput_.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class MessageNotificationController : BaseCRUDController<MessageNotification, hajUsput.Model.SearchObjects.MessageNotificationSearchObject, hajUsput.Model.Requests.MessageNotificationInsertRequest, hajUsput.Model.Requests.MessageNotificationUpdateRequest>

    {
        public MessageNotificationController(ILogger<BaseController<MessageNotification, hajUsput.Model.SearchObjects.MessageNotificationSearchObject>> logger, IMessageNotificationService service) : base(logger,service)
        {
        }
    }
}
