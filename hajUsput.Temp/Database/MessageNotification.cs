using System;
using System.Collections.Generic;

namespace hajUsput.Services.Database;

public partial class MessageNotification
{
    public int MessageId { get; set; }

    public int? SenderId { get; set; }

    public int? ReceiverId { get; set; }

    public string? MessageContent { get; set; }

    public DateTime? MessageDate { get; set; }

    public virtual User? Receiver { get; set; }

    public virtual User? Sender { get; set; }
}
