using System;
using System.Collections.Generic;

namespace hajUsput.Model
{

    public partial class ReviewRating
    {


        public int ReviewId { get; set; }

        public int? RideId { get; set; }

        public int? ReviewerId { get; set; }

        public int? Rating { get; set; }

        public string Comments { get; set; }

        public DateTime? ReviewDate { get; set; }
    }

}