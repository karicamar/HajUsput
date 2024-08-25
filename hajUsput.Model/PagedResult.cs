using System;
using System.Collections.Generic;
using System.Text;

namespace hajUsput.Model
{
    public class PagedResult<T>
    {
        public IList<T> Result { get; set; }
        public int? Count { get; set; }
    }
}
