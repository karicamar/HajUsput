using System;
using System.Collections.Generic;

namespace hajUsput.Services.Database;

public partial class Booking
{
    public int BookingId { get; set; }

    public int? RideId { get; set; }

    public int? PassengerId { get; set; }

    public string? BookingStatus { get; set; }

    public DateTime? BookingDate { get; set; }
    public int? PaymentId { get; set; }

    public virtual User? Passenger { get; set; }

    public virtual Ride? Ride { get; set; }
    public virtual Payment? Payment { get; set; }
}
