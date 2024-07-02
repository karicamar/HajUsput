
using AutoMapper;
using hajUsput.Model;
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
    public class RideService : BaseCRUDService<Model.Ride, Database.Ride, RideSearchObject, RideInsertRequest, RideUpdateRequest>, IRideService
    {

        public RideService(_180072Context context, IMapper mapper) : base(context, mapper)
        {
           
            
        }
        
    }
}
