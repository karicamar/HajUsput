using System;
using System.Collections.Generic;
using System.Text;

namespace hajUsput.Model.SearchObjects
{
    public class ReviewRatingSearchObject : BaseSearchObject
    {

      
        public int stars {  get; set; }
        public string FTS { get; set; }

    }
}
