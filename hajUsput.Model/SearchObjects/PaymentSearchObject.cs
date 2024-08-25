using System;
using System.Collections.Generic;
using System.Text;

namespace hajUsput.Model.SearchObjects
{
    public class PaymentSearchObject : BaseSearchObject
    {
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public string PaymentStatus { get; set; }
        public string PaymentMethod { get; set; }
    }
}
