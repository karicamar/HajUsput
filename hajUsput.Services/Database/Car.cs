﻿using System;
using System.Collections.Generic;

namespace hajUsput.Services.Database;

public partial class Car
{
    public int CarId { get; set; }

    public int? DriverId { get; set; }

    public int CarMakeId { get; set; } 

    public string Color { get; set; } = null!;

    public int? YearOfManufacture { get; set; }

    public string? LicensePlateNumber { get; set; }

    public virtual User? Driver { get; set; }
    public virtual CarMake CarMake { get; set; } = null!;

}
