
using AutoMapper;
using hajUsput.ML.DataStructures;
using hajUsput.Model;
using hajUsput.Model.Requests;
using hajUsput.Model.SearchObjects;
using hajUsput.Services.Database;
using hajUsput.Services.StateMachines;
using Hangfire;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.ML;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Ride = hajUsput.Services.Database.Ride;


namespace hajUsput.Services
{
    public class RideService : BaseCRUDService<Model.Ride, Database.Ride, RideSearchObject, RideInsertRequest, RideUpdateRequest>, IRideService
    {
        private readonly ILogger<RideService> _logger;
        private readonly MLContext _mlContext;
        private readonly ITransformer _model;
        private readonly object _lock = new object();
        private readonly string _modelPath= "../hajUsput.ML/MLModels/PricePredictionModel.zip";
       
        public RideService(_180072Context context, IMapper mapper, ILogger<RideService> logger) : base(context, mapper)
        {
            _logger = logger;
            _mlContext = new MLContext();
            
            _model = _mlContext.Model.Load(_modelPath, out _);

        }
        public float PredictPrice(PredictionRequest request)
        {
            lock (_lock)
            {
                var rideData = new RideData
                {
                    DepartureCity = request.DepartureCity,
                    DestinationCity = request.DestinationCity,
                    DistanceInKm = request.DistanceInKm,
                    DurationInMinutes = request.DurationInMinutes,
                    AvailableSeats = request.AvailableSeats
                };

                var predictionEngine = _mlContext.Model.CreatePredictionEngine<RideData, RidePricePrediction>(_model);
                var prediction = predictionEngine.Predict(rideData);

                return prediction.Price;
            }
        }
        public void UpdateRideStatus(int rideId, RideStateMachine.Trigger trigger)
        {
            var ride = _context.Rides.Find(rideId);
            if (ride == null)
                throw new Exception("Ride not found");

            var rideStateMachine = new RideStateMachine((RideStateMachine.State)Enum.Parse(typeof(RideStateMachine.State), ride.RideStatus));

            switch (trigger)
            {
                case RideStateMachine.Trigger.FillSeats:
                    rideStateMachine.FillSeats();
                    break;
                case RideStateMachine.Trigger.CancelRide:
                    rideStateMachine.CancelRide();
                    break;
                case RideStateMachine.Trigger.ArchiveRide:
                    rideStateMachine.ArchiveRide();
                    break;
            }

            ride.RideStatus = rideStateMachine.CurrentState.ToString();
            _context.SaveChanges();
        }

        public override IQueryable<Ride> AddFilter(IQueryable<Ride> query, RideSearchObject? search = null)
        {
            query = base.AddFilter(query, search);

            if (search?.DepartureLocationId.HasValue ?? false)
            {
                query = query.Where(x => x.DepartureLocationId == search.DepartureLocationId.Value);
            }
            if (search?.DestinationLocationId.HasValue ?? false)
            {
                query = query.Where(x => x.DestinationLocationId == search.DestinationLocationId.Value);
            }
            if (search?.Date != null)
            {
                var searchDate = search.Date.Value.Date;
                query = query.Where(x => x.DepartureDate.Date == searchDate);
            }

            return query;
        }
        public override async Task<Model.Ride> Insert(RideInsertRequest request)
        {
            var ride = await base.Insert(request);

            // Schedule a job to archive the ride 24 hours after its departure date and time
            BackgroundJob.Schedule(() => ArchiveRide(ride.RideId), ride.DepartureDate.AddHours(24));

            return ride;
        }
        public void ReduceAvailableSeats(int rideId)
        {
            var ride = _context.Rides.Find(rideId);
            if (ride == null)
                throw new Exception("Ride not found");

            if (ride.AvailableSeats < 1)
                throw new Exception("Not enough seats available");

            ride.AvailableSeats -= 1;

            if (ride.AvailableSeats == 0)
            {
                UpdateRideStatus(rideId, RideStateMachine.Trigger.FillSeats);
            }

            _context.SaveChanges();
        }

        public void ArchiveRide(int rideId)
        {
            var ride = _context.Rides.Find(rideId);
            if (ride == null)
            {
                _logger.LogError($"Ride with ID {rideId} not found.");
                return;
            }

            if (ride.RideStatus != RideStateMachine.State.Archived.ToString() && ride.DepartureDate.AddHours(24) <= DateTime.Now)
            {
                UpdateRideStatus(rideId, RideStateMachine.Trigger.ArchiveRide);
                _logger.LogInformation($"Ride with ID {rideId} has been archived.");
            }
        }
        public List<Model.Ride> GetUserRides(int userId)
        {
            var query = _context.Rides.AsQueryable();

            query = query.Where(x => x.DriverId == userId || x.Bookings.Any(b => b.PassengerId == userId));

            var rides = query.ToList();

            return _mapper.Map<List<Model.Ride>>(rides);
        }
        public async Task<int> GetTotalRidesAsync()
        {
            return await _context.Rides.CountAsync();
        }
        
        public double GetTotalDistanceTraveled()
        {
            return _context.Rides
                .Where(ride => ride.RideStatus == RideStateMachine.State.Archived.ToString())
                .Sum(ride => ride.Distance);
        }
        public double GetAverageRideDistance()
        {
            return _context.Rides
                .Where(ride => ride.RideStatus == RideStateMachine.State.Archived.ToString())
                .Average(ride => ride.Distance);
        }
        public async Task<int> GetScheduledRidesAsync()
        {
            return await _context.Rides.CountAsync(ride =>
                ride.RideStatus == RideStateMachine.State.Scheduled.ToString() ||
                ride.RideStatus == RideStateMachine.State.Full.ToString());
        }
        public async Task<int> GetArchivedRidesAsync()
        {
            return await _context.Rides.CountAsync(ride => ride.RideStatus == RideStateMachine.State.Archived.ToString());
        }
        public async Task<int> GetCancelledRidesAsync()
        {
            return await _context.Rides.CountAsync(ride => ride.RideStatus == RideStateMachine.State.Cancelled.ToString());
        }
        
    }
}
