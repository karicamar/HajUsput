﻿



using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;

namespace hajUsput.Services
{
    public interface IMessageNotificationService :  ICRUDService<MessageNotification, MessageNotificationSearchObject, MessageNotificationInsertRequest, MessageNotificationUpdateRequest>

    {
        // Model.User Login(string username, string password);


        Task<List<Model.MessageNotification>> GetMessagesForUser(int userId);
        Task<Model.MessageNotification> SendMessage(MessageNotificationInsertRequest request);


    }
}