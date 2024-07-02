using System;
using System.Collections.Generic;

namespace hajUsput.Model
{

    public partial class Ride
    {


        public int RideId { get; set; }

        public int? DriverId { get; set; }

        public int? DepartureLocationId { get; set; }

        public int? DestinationLocationId { get; set; }

        public DateTime DepartureDate { get; set; }

        public int? AvailableSeats { get; set; }

        public string RideStatus { get; set; }

        public int? Price { get; set; }

        //public string LicensePlateNumber { get; set; }

        //public virtual User? Driver { get; set; }
    }

}