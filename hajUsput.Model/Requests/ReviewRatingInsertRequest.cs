using System;
using System.Collections.Generic;
using System.Text;

namespace hajUsput.Model.Requests
{
    public class ReviewRatingInsertRequest
    {

        public int DriverId { get; set; }

        public int ReviewerId { get; set; }

        public int Rating { get; set; }

        public string Comments { get; set; }

        public DateTime ReviewDate { get; set; }
    }
}
