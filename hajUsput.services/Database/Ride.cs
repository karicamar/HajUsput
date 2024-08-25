using System;
using System.Collections.Generic;

namespace hajUsput.Services.Database;

public partial class Ride
{
    public int RideId { get; set; }

    public int? DriverId { get; set; }

    public int? DepartureLocationId { get; set; }

    public int? DestinationLocationId { get; set; }

    public DateTime DepartureDate { get; set; }

    public double Distance { get; set; } 
    public double Duration { get; set; }
    public int? AvailableSeats { get; set; }

    public string? RideStatus { get; set; }

    public int? Price { get; set; }
    public virtual ICollection<Booking> Bookings { get; set; } = new List<Booking>();

    public virtual Location? DepartureLocation { get; set; }

    public virtual Location? DestinationLocation { get; set; }

    public virtual User? Driver { get; set; }

    public virtual ICollection<Payment> Payments { get; set; } = new List<Payment>();

    public virtual ICollection<ReviewRating> ReviewRatings { get; set; } = new List<ReviewRating>();
}
