using System;
using System.Collections.Generic;
using System.Text;

namespace hajUsput.Model.Requests
{
    public class ReviewRatingUpdateRequest
    {

        public int Rating { get; set; }

        public string Comments { get; set; }

        public DateTime ReviewDate { get; set; }
    }
}
