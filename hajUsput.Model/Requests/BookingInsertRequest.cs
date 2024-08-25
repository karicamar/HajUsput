using System;
using System.Collections.Generic;
using System.Text;

namespace hajUsput.Model.Requests
{
    public class BookingInsertRequest
    {




        

        public int RideId { get; set; }

        public int PassengerId { get; set; }

        public string BookingStatus { get; set; }

        public DateTime BookingDate { get; set; }
        public int? PaymentId { get; set; }

    }
}