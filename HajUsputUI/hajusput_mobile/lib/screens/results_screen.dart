import 'package:flutter/material.dart';
import 'package:hajusput_mobile/models/ride.dart';
import 'package:hajusput_mobile/providers/location_provider.dart';
import 'package:hajusput_mobile/providers/review_provider.dart';
import 'package:hajusput_mobile/providers/ride_provider.dart';
import 'package:hajusput_mobile/providers/user_provider.dart';
import 'package:hajusput_mobile/screens/ride_details_screen.dart';
import 'package:hajusput_mobile/utils/utils.dart';
import 'package:provider/provider.dart';

class ResultsScreen extends StatefulWidget {
  final String leavingFrom;
  final String goingTo;
  final String date;

  ResultsScreen({
    required this.leavingFrom,
    required this.goingTo,
    required this.date,
  });

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late Future<List<Ride>> _ridesFuture;
  Map<int?, String> driverNames = {};
  Map<int?, double?> driverRatings = {};
  int? departureLocationId;
  int? destinationLocationId;

  @override
  void initState() {
    super.initState();
    print('Error fetching driver details: ${widget.leavingFrom}');
    _ridesFuture = _fetchLocationIds(widget.leavingFrom, widget.goingTo);
  }

  Future<List<Ride>> _fetchLocationIds(String leaving, String going) async {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);

    // Fetch location IDs
    final locationStart = await locationProvider.fetchLocationId(leaving);
    final locationEnd = await locationProvider.fetchLocationId(going);

    setState(() {
      departureLocationId = locationStart;
      destinationLocationId = locationEnd;
    });

    // Fetch rides after location IDs are retrieved
    return _fetchRides();
  }

  Future<List<Ride>> _fetchRides() async {
    final rideProvider = Provider.of<RideProvider>(context, listen: false);
    print(
        'Error fetching driver details: $destinationLocationId $departureLocationId');
    // Ensure location IDs are available before fetching rides
    if (departureLocationId == null || destinationLocationId == null) {
      return [];
    }

    final result = await rideProvider.get(filter: {
      'departureLocationId': departureLocationId,
      'destinationLocationId': destinationLocationId,
      'date': widget.date,
    });
    List<Ride> rides = result.result;

    // Fetch additional details for each ride
    await Future.wait(
        rides.map((ride) => _fetchDriverDetailsAndRating(ride.driverId)));

    return rides;
  }

  Future<void> _fetchDriverDetailsAndRating(int? driverId) async {
    if (driverId == null) return;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final reviewRatingProvider =
        Provider.of<ReviewProvider>(context, listen: false);

    try {
      final driver = await userProvider.getById(driverId);
      final rating = await reviewRatingProvider.getDriverRating(driverId);

      setState(() {
        driverNames[driverId] = '${driver.firstName} ${driver.lastName}';
        driverRatings[driverId] = rating;
      });
    } catch (e) {
      // Handle the error appropriately
      print('Error fetching driver details: $e');
    }
  }

  String _calculateDestinationTime(
      DateTime? departureDateTime, int durationInMinutes) {
    final destinationTime =
        departureDateTime?.add(Duration(minutes: durationInMinutes));
    return formatTime(destinationTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rides from ${widget.leavingFrom} to ${widget.goingTo}'),
            FutureBuilder<List<Ride>>(
              future: _ridesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox.shrink(); // Empty widget while loading
                } else if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data!.isEmpty) {
                  return SizedBox.shrink(); // Empty widget on error or no data
                } else {
                  final rides = snapshot.data!;
                  final departureDate = formatDate(rides.first.departureDate);
                  return Text('Date: $departureDate');
                }
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade300,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<Ride>>(
          future: _ridesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No active rides for your parameters'));
            } else {
              final rides = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: rides.length,
                itemBuilder: (context, index) {
                  final ride = rides[index];
                  final departureTime = formatTime(ride.departureDate);
                  final destinationTime = _calculateDestinationTime(
                      ride.departureDate, ride.duration!.toInt());
                  final driverName = driverNames[ride.driverId] ?? 'Loading...';
                  final driverRating = driverRatings[ride.driverId];

                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RideDetailsScreen(ride: ride),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                            child: Row(
                              children: [
                                Icon(Icons.person_pin_circle, size: 28),
                                SizedBox(width: 8),
                                Text(departureTime,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(width: 8),
                                Expanded(child: Divider()),
                                SizedBox(width: 8),
                                Icon(Icons.pin_drop, size: 28),
                                SizedBox(width: 8),
                                Text(destinationTime,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          Divider(), // Horizontal Divider
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.person, size: 24),
                                        SizedBox(width: 4),
                                        Text(driverName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    if (driverRating != null)
                                      Row(
                                        children: [
                                          Icon(Icons.star,
                                              color: Colors.yellow, size: 24),
                                          SizedBox(width: 4),
                                          Text(
                                              '${driverRating.toStringAsFixed(1)}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.euro, size: 24),
                                        SizedBox(width: 4),
                                        Text(
                                            '${ride.price?.toStringAsFixed(2)}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.event_seat, size: 24),
                                        SizedBox(width: 4),
                                        Text('${ride.availableSeats}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
