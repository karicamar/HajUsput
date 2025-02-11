using System;
using System.Collections.Generic;

namespace hajUsput.Services.Database;

public partial class ReviewRating
{
    public int ReviewId { get; set; }

    public int? DriverId { get; set; }

    public int? ReviewerId { get; set; }

    public int? RideId { get; set; }

    public int? Rating { get; set; }

    public string? Comments { get; set; }

    public DateTime? ReviewDate { get; set; }

    public virtual User? Reviewer { get; set; }

    public virtual User? Driver { get; set; }

    public virtual Ride? Ride { get; set; }
}
