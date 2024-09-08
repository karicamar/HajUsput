
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
    public class ReviewRatingService : BaseCRUDService<Model.ReviewRating, Database.ReviewRating, ReviewRatingSearchObject, ReviewRatingInsertRequest, ReviewRatingUpdateRequest>, IReviewRatingService
    {

        public ReviewRatingService(_180072Context context, IMapper mapper) : base(context, mapper)
        {

        }

        public async Task<double?> GetDriverRatingAsync(int driverId)
        {
            var reviews = await _context.ReviewRatings.Where(r => r.DriverId == driverId).ToListAsync();
            if (reviews.Count == 0)
            {
                return null;
            }
            return reviews.Average(r => r.Rating);
        }
        public async Task<Dictionary<string, List<Model.ReviewRating>>> GetRatingsByUser(int userId)
        {
            var reviewRatings = await _context.ReviewRatings
                .Where(r => r.DriverId == userId || r.ReviewerId == userId)
                .ToListAsync();

            // Separate into given and received reviews
            var givenReviews = reviewRatings.Where(r => r.ReviewerId == userId).ToList();
            var receivedReviews = reviewRatings.Where(r => r.DriverId == userId).ToList();

            // Map the database models to the DTO models
            var mappedGivenReviews = _mapper.Map<List<Model.ReviewRating>>(givenReviews);
            var mappedReceivedReviews = _mapper.Map<List<Model.ReviewRating>>(receivedReviews);

            // Create and return the dictionary
            return new Dictionary<string, List<Model.ReviewRating>>
            {
                { "GivenReviews", mappedGivenReviews },
                { "ReceivedReviews", mappedReceivedReviews }
            };
        }

    }
}
