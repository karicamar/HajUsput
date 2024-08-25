using System;
using System.Collections.Generic;
using System.Text;

namespace hajUsput.Model.Requests
{
    public class PreferenceUpsertRequest
    {


        public string IsChatty { get; set; }
        public string AllowsMusic { get; set; }
        public string AllowsSmoking { get; set; }
        public string AllowsPets { get; set; }
    }
}
