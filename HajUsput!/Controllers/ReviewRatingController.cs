
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services;
using hajUsput.Services.Database;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HajUsput_.Controllers
{
    [ApiController]
    [Route("[controller]")]
    [Authorize(Roles = "User,Admin")]

    public class ReviewRatingController : BaseCRUDController<hajUsput.Model.ReviewRating, hajUsput.Model.SearchObjects.ReviewRatingSearchObject, hajUsput.Model.Requests.ReviewRatingInsertRequest, hajUsput.Model.Requests.ReviewRatingUpdateRequest>

    {
        private readonly IReviewRatingService _reviewRatingService;
        public ReviewRatingController(ILogger<BaseController<hajUsput.Model.ReviewRating, hajUsput.Model.SearchObjects.ReviewRatingSearchObject>> logger, IReviewRatingService service) : base(logger,service)
        {
            _reviewRatingService= service;
        }


        [HttpGet("driver/{driverId}/rating")]
        [AllowAnonymous]

        public async Task<IActionResult> GetDriverRating(int driverId)
        {
            var rating = await _reviewRatingService.GetDriverRatingAsync(driverId);
            if (rating == null)
            {
                return NotFound();
            }
            return Ok(rating);
        }
        [HttpGet("user/{userId}")]
        public async Task<IActionResult> GetRatingsByUser(int userId)
        {
            var ratings = await _reviewRatingService.GetRatingsByUser(userId);

            if (ratings == null || ratings.Count == 0)
            {
                return NotFound("No ratings found for this user.");
            }

            return Ok(ratings);
        }
    }
}
