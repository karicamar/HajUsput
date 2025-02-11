
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
    public class LocationService : BaseCRUDService<Model.Location, Database.Location, LocationSearchObject, LocationInsertRequest, LocationUpdateRequest>, ILocationService
    {

        public LocationService(_180072Context context, IMapper mapper) : base(context, mapper)
        {

        }
        public async Task<int?> GetLocationIdByCityAsync(string city)
        {
            var location = await _context.Locations
                .FirstOrDefaultAsync(l => l.City.ToLower() == city.ToLower());

            return location?.LocationId;
        }
        public override IQueryable<Database.Location> AddFilter(IQueryable<Database.Location> query, LocationSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.City))
            {
                filteredQuery = filteredQuery.Where(x => x.City.Contains(search.City));
            }

            return filteredQuery;
        }
    }
}
