
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services;
using Microsoft.AspNetCore.Mvc;

namespace HajUsput_.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ReviewRatingController : BaseCRUDController<ReviewRating, hajUsput.Model.SearchObjects.ReviewRatingSearchObject, hajUsput.Model.Requests.ReviewRatingInsertRequest, hajUsput.Model.Requests.ReviewRatingUpdateRequest>

    {
        public ReviewRatingController(ILogger<BaseController<ReviewRating, hajUsput.Model.SearchObjects.ReviewRatingSearchObject>> logger, IReviewRatingService service) : base(logger,service)
        {
        }
    }
}
