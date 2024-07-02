using System;
using System.Collections.Generic;
using System.Text;

namespace hajUsput.Model.Requests
{
    public class PaymentInsertRequest
    {

        public int RideId { get; set; }

        public int PayerId { get; set; }

        public decimal Amount { get; set; }

        public string PaymentStatus { get; set; }

        public DateTime PaymentDate { get; set; }
    }
}
