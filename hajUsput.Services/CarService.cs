
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
    public class CarService : BaseCRUDService<Model.Car, Database.Car, CarSearchObject, CarInsertRequest, CarUpdateRequest>, ICarService
    {

        public CarService(_180072Context context, IMapper mapper) : base(context, mapper)
        {

        }
        public Model.Car GetCarsByUserId(int userId)
        {
            var car = _context.Cars
        .FirstOrDefault(c => c.DriverId == userId);

            if (car == null)
                throw new Exception("Car not found");

            return _mapper.Map<Model.Car>(car);
        }
        public override IQueryable<Database.Car> AddInclude(IQueryable<Database.Car> query, CarSearchObject? search = null)
        {
           
                query = query.Include("CarMake");
            
            return base.AddInclude(query, search);
        }
    }
}
