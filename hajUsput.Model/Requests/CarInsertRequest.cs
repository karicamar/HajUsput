using System;
using System.Collections.Generic;
using System.Text;

namespace hajUsput.Model.Requests
{
    public class CarInsertRequest
    {



        // public int? DriverId { get; set; }

        public string Make { get; set; }

        public string CarType { get; set; }

        public string Color { get; set; }

        public int? YearOfManufacture { get; set; }

        public string LicensePlateNumber { get; set; }

        //public virtual User? Driver { get; set; }
    }
}
