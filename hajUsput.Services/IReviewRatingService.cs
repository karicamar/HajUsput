



using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;

namespace hajUsput.Services
{
    public interface IReviewRatingService :  ICRUDService<ReviewRating, ReviewRatingSearchObject, ReviewRatingInsertRequest, ReviewRatingUpdateRequest>

    {
        // Model.User Login(string username, string password);
        public Task<double?> GetDriverRatingAsync(int driverId);

        public Task<Dictionary<string, List<Model.ReviewRating>>> GetRatingsByUser(int userId);




    }
}