using System;
using System.Collections.Generic;

namespace hajUsput.Services.Database;

public partial class Preference
{
    public int PreferenceId { get; set; }
    public string? IsChatty { get; set; }
    public string? AllowsMusic { get; set; }
    public string? AllowsSmoking { get; set; }
    public string? AllowsPets { get; set; }
    public int? UserId { get; set; }
    public virtual User? user { get; set; }
}
