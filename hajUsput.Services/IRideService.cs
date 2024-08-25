
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;

namespace hajUsput.Services
{
    public interface IRideService :  ICRUDService<Ride, RideSearchObject, RideInsertRequest, RideUpdateRequest>

    {


        float PredictPrice(PredictionRequest request);
        void UpdateRideStatus(int rideId, RideStateMachine.Trigger trigger);
        void ReduceAvailableSeats(int rideId);
        public List<Model.Ride> GetUserRides(int userId);
        public Task<int> GetTotalRidesAsync();

        public Task<int> GetScheduledRidesAsync();
        public Task<int> GetCancelledRidesAsync();
        public Task<int> GetArchivedRidesAsync();
        public double GetTotalDistanceTraveled();
        public double GetAverageRideDistance();




    }
}