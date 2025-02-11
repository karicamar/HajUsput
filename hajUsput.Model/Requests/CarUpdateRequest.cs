using System;
using System.Collections.Generic;
using System.Text;

namespace hajUsput.Model.Requests
{
    public class CarUpdateRequest
    {



        public int? DriverId { get; set; }

        public int? CarMakeId { get; set; }

        public string Color { get; set; }

        public int? YearOfManufacture { get; set; }

        public string LicensePlateNumber { get; set; }

        //public virtual User? Driver { get; set; }
    }
}
