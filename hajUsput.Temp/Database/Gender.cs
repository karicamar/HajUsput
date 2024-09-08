using System;
using System.Collections.Generic;

namespace hajUsput.Services.Database;

public partial class Gender
{
    public int GenderId { get; set; }

    public string GenderName { get; set; } = null!;

    public virtual ICollection<User> Users { get; set; } = new List<User>();
}
