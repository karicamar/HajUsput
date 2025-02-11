using System;
using System.Collections.Generic;

namespace hajUsput.Model
{

    public partial class Car
    {
       

        public int CarId { get; set; }

        public int? DriverId { get; set; }

        public int CarMakeId { get; set; }

        public string Color { get; set; } 

        public int? YearOfManufacture { get; set; }

        public string LicensePlateNumber { get; set; }

        public virtual CarMake CarMake { get; set; }

    }

}