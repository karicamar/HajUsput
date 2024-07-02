using System;
using System.Collections.Generic;
using System.Text;

namespace hajUsput.Model.SearchObjects
{
    public class UserSearchObject : BaseSearchObject
    {

        public bool? IsRoleIncluded { get; set; }

        public string FTS { get; set; }

    }
}
