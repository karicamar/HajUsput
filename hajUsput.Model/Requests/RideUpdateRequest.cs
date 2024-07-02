using System;
using System.Collections.Generic;
using System.Text;

namespace hajUsput.Model.Requests
{
    public class RideUpdateRequest
    {


        public int? DriverId { get; set; }

        public int? DepartureLocationId { get; set; }

        public int? DestinationLocationId { get; set; }

        public DateTime? DepartureDate { get; set; }


        public int? AvailableSeats { get; set; }

        public string RideStatus { get; set; }

        public int? Price { get; set; }
    }
}
