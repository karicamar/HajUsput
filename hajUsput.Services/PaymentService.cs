
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
    public class PaymentService : BaseCRUDService<Model.Payment, Database.Payment, BaseSearchObject, PaymentInsertRequest, PaymentUpdateRequest>, IPaymentService
    {

        public PaymentService(_180072Context context, IMapper mapper) : base(context, mapper)
        {

        }
        
    }
}
