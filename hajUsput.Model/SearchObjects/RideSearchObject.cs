using System;
using System.Collections.Generic;
using System.Text;

namespace hajUsput.Model.SearchObjects
{
    public class RideSearchObject : BaseSearchObject
    {

        public int? DepartureLocationId { get; set; }
        public int? DestinationLocationId { get; set; }

        public DateTime? Date { get; set; }
        public string FTS { get; set; }

    }
}
