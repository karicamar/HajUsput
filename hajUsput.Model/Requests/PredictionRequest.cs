using System;
using System.Collections.Generic;
using System.Text;

namespace hajUsput.Model.Requests
{
    public class PredictionRequest
    {
        public string DepartureCity { get; set; }
        public string DestinationCity { get; set; }
        public float DistanceInKm { get; set; }
        public float DurationInMinutes { get; set; }
        public float AvailableSeats { get; set; }
    }
}