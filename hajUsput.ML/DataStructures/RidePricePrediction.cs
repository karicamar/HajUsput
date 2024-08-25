using Microsoft.ML.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hajUsput.ML.DataStructures
{
    public class RidePricePrediction
    {
        [ColumnName("Score")] public float Price;
    }
}
