using Microsoft.ML.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hajUsput.ML.DataStructures
{
    public class RideData
    {
        [LoadColumn(0)]
        public string DepartureCity { get; set; }

        [LoadColumn(1)]
        public string DestinationCity { get; set; }

        [LoadColumn(2)]
        public float DistanceInKm { get; set; }

        [LoadColumn(3)]
        public float DurationInMinutes { get; set; }

        [LoadColumn(4)]
        public float AvailableSeats { get; set; }

        [LoadColumn(5)]
        public float Price { get; set; }
    }
}
