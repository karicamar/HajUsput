
using AutoMapper;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace hajUsput.Services
{
    public class CarMakeService : BaseCRUDService<Model.CarMake, Database.CarMake, CarMakeSearchObject, CarMakeUpsertRequest, CarMakeUpsertRequest>, ICarMakeService
    {

        public CarMakeService(_180072Context context, IMapper mapper) : base(context, mapper)
        {

        }
        public override IQueryable<Database.CarMake> AddFilter(IQueryable<Database.CarMake> query, CarMakeSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.CarMake))
            {
                filteredQuery = filteredQuery.Where(x => x.Name.Contains(search.CarMake));
            }

            return filteredQuery;
        }
    }
}
