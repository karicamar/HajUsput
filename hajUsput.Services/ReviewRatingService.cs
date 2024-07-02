
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
    public class ReviewRatingService : BaseCRUDService<Model.ReviewRating, Database.ReviewRating, ReviewRatingSearchObject, ReviewRatingInsertRequest, ReviewRatingUpdateRequest>, IReviewRatingService
    {

        public ReviewRatingService(_180072Context context, IMapper mapper) : base(context, mapper)
        {

        }
        
    }
}
