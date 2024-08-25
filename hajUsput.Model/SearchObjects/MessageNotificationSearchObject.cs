using System;
using System.Collections.Generic;
using System.Text;

namespace hajUsput.Model.SearchObjects
{
    public class MessageNotificationSearchObject : BaseSearchObject
    {


        public int? SenderId { get; set; }
        public int? ReceiverId { get; set; }
        public DateTime? FromDate { get; set; }
        public DateTime? ToDate { get; set; }

    }
}
