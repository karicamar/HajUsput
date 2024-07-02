using System;
using System.Collections.Generic;

namespace hajUsput.Model
{

    public partial class Booking
    {


        public int BookingId { get; set; }

        public int? RideId { get; set; }

        public int? PassengerId { get; set; }

        public string BookingStatus { get; set; }

        public DateTime? BookingDate { get; set; }

        //public string LicensePlateNumber { get; set; }

        //public virtual User? Driver { get; set; }
    }

}