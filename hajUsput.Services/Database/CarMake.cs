using System;
using System.Collections.Generic;

namespace hajUsput.Services.Database;

public partial class CarMake
{
    public int CarMakeId { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<Car> Cars { get; set; } = new List<Car>();

}
