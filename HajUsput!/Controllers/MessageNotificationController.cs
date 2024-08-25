﻿
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HajUsput_.Controllers
{
    [ApiController]
    [Route("[controller]")]
    [Authorize(Roles = "User,Admin")]

    public class MessageNotificationController : BaseCRUDController<MessageNotification, hajUsput.Model.SearchObjects.MessageNotificationSearchObject, hajUsput.Model.Requests.MessageNotificationInsertRequest, hajUsput.Model.Requests.MessageNotificationUpdateRequest>

    {
        private readonly IMessageNotificationService _messageNotificationService;
        public MessageNotificationController(ILogger<BaseController<MessageNotification, hajUsput.Model.SearchObjects.MessageNotificationSearchObject>> logger, IMessageNotificationService service) : base(logger,service)
        {
            _messageNotificationService = service;
        }

        [HttpGet("user/{userId}")]
        public async Task<IActionResult> GetMessagesForUser(int userId)
        {
            var messages = await _messageNotificationService.GetMessagesForUser(userId);
            return Ok(messages);
        }

        // Send a new message
        [HttpPost("send")]
        public async Task<IActionResult> SendMessage([FromBody] MessageNotificationInsertRequest request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var message = await _messageNotificationService.SendMessage(request);
            return Ok(message);
        }
    }
}
