import 'package:flutter/material.dart';
import 'package:hajusput_mobile/screens/ride_details_screen.dart';
import 'package:hajusput_mobile/utils/utils.dart';
import 'package:provider/provider.dart';
import '../providers/ride_provider.dart';
import '../providers/booking_provider.dart';
import '../providers/location_provider.dart';
import '../models/ride.dart';
import '../models/booking.dart';
import '../utils/user_session.dart';
import '../widgets/master_screen.dart';

class RidesScreen extends StatefulWidget {
  @override
  _RidesScreenState createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  late Future<List<Ride>> _ridesFuture;
  late Future<List<Booking>> _bookingsFuture;
  List<Ride> scheduledRides = [];
  List<Ride> fullRides = [];
  List<Ride> archivedRides = [];
  List<Ride> cancelledRides = [];
  Map<int, Booking?> bookingsMap = {};

  @override
  void initState() {
    super.initState();
    _loadRidesAndBookings();
  }

  void _loadRidesAndBookings() {
    int userId = UserSession.userId!;
    _ridesFuture =
        Provider.of<RideProvider>(context, listen: false).getUserRides(userId);
    _bookingsFuture = Provider.of<BookingProvider>(context, listen: false)
        .getUserBookings(userId);
  }

  void _filterRides(List<Ride> rides) {
    scheduledRides =
        rides.where((ride) => ride.rideStatus == 'Scheduled').toList();
    fullRides = rides.where((ride) => ride.rideStatus == 'Full').toList();
    archivedRides =
        rides.where((ride) => ride.rideStatus == 'Archived').toList();
    cancelledRides =
        rides.where((ride) => ride.rideStatus == 'Cancelled').toList();
  }

  Future<String> _fetchLocationName(int locationId) async {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    final location = await locationProvider.getById(locationId);
    return location.city;
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Rides',
      content: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.green.shade300,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<Ride>>(
          future: _ridesFuture,
          builder: (context, rideSnapshot) {
            if (rideSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (rideSnapshot.hasError) {
              return Center(child: Text('Error: ${rideSnapshot.error}'));
            } else if (!rideSnapshot.hasData || rideSnapshot.data!.isEmpty) {
              return Center(child: Text('No rides available.'));
            } else {
              _filterRides(rideSnapshot.data!);

              return FutureBuilder<List<Booking>>(
                future: _bookingsFuture,
                builder: (context, bookingSnapshot) {
                  if (bookingSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (bookingSnapshot.hasError) {
                    return Center(
                        child: Text('Error: ${bookingSnapshot.error}'));
                  } else if (!bookingSnapshot.hasData ||
                      bookingSnapshot.data!.isEmpty) {
                    return Center(child: Text('No bookings available.'));
                  } else {
                    // Map bookings by RideId
                    bookingsMap = {
                      for (var booking in bookingSnapshot.data!)
                        if (booking.rideId != null) booking.rideId!: booking
                    };

                    return DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: TabBar(
                              labelColor: Colors.green.shade600,
                              indicatorColor: Colors.green.shade600,
                              unselectedLabelColor: Colors.grey,
                              tabs: [
                                Tab(text: 'Scheduled'),
                                Tab(text: 'Archived/Cancelled'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                _buildRideList(scheduledRides + fullRides),
                                _buildRideList(archivedRides + cancelledRides),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      ),
      currentIndex: 2,
    );
  }

  Widget _buildRideList(List<Ride> rides) {
    if (rides.isEmpty) {
      return Center(child: Text('No rides available.'));
    }
    return ListView.builder(
      itemCount: rides.length,
      itemBuilder: (context, index) {
        final ride = rides[index];
        final booking = bookingsMap[ride.rideId];

        return FutureBuilder<List<String>>(
          future: Future.wait([
            _fetchLocationName(ride.departureLocationId),
            _fetchLocationName(ride.destinationLocationId),
          ]),
          builder: (context, locationSnapshot) {
            if (locationSnapshot.connectionState == ConnectionState.waiting) {
              return ListTile(
                title: Text('Loading...'),
                subtitle: Text('Fetching location data...'),
              );
            } else if (locationSnapshot.hasError) {
              return ListTile(
                title: Text('Error loading location'),
                subtitle: Text('Failed to load location data'),
              );
            } else if (locationSnapshot.hasData) {
              final departureLocation = locationSnapshot.data![0];
              final destinationLocation = locationSnapshot.data![1];

              return Card(
                child: ListTile(
                  leading: Icon(
                    ride.rideStatus == 'Cancelled'
                        ? Icons.cancel
                        : Icons.directions_car,
                    color: ride.rideStatus == 'Cancelled'
                        ? Colors.red
                        : Colors.green.shade600,
                  ),
                  title: Text('$departureLocation to $destinationLocation'),
                  subtitle: Text(
                    '${formatDate(ride.departureDate!)}, ${formatTime(ride.departureDate!)} - ${ride.availableSeats} seats left\n'
                    '${booking?.bookingStatus == 'Confirmed' ? 'Booked' : ''}',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RideDetailsScreen(ride: ride),
                      ),
                    );
                  },
                ),
              );
            } else {
              return ListTile(
                title: Text('Location data not available'),
              );
            }
          },
        );
      },
    );
  }
}
