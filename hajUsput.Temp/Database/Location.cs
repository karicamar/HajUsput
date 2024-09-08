using System;
using System.Collections.Generic;

namespace hajUsput.Services.Database;

public partial class Location
{
    public int LocationId { get; set; }

    public string? City { get; set; }

    public string? Country { get; set; }

    public virtual ICollection<Ride> RideDepartureLocations { get; set; } = new List<Ride>();

    public virtual ICollection<Ride> RideDestinationLocations { get; set; } = new List<Ride>();
}
