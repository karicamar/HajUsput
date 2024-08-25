using System;
using System.Collections.Generic;
using System.Text;

namespace hajUsput.Model.Requests
{
    public class MessageNotificationInsertRequest
    {

        public int? SenderId { get; set; }
        public int? ReceiverId { get; set; }
        public string MessageContent { get; set; }
        public DateTime? MessageDate { get; set; }
    }
}
