using System;
using System.Collections.Generic;

namespace hajUsput.Services.Database;

public partial class Payment
{
    public int PaymentId { get; set; }

    public int? RideId { get; set; }

    public int? PayerId { get; set; }

    public decimal? Amount { get; set; }

    public string? PaymentStatus { get; set; }
    public string? PaymentMethod { get; set; }


    public DateTime? PaymentDate { get; set; }
    
    public virtual User? Payer { get; set; }

    public virtual Ride? Ride { get; set; }
}
