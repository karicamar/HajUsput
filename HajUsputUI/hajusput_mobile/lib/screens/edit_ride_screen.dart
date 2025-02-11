import 'package:flutter/material.dart';
import 'package:hajusput_mobile/models/ride.dart';
import 'package:hajusput_mobile/providers/location_provider.dart';
import 'package:hajusput_mobile/providers/ride_provider.dart';
import 'package:hajusput_mobile/screens/date_time_screen.dart';
import 'package:hajusput_mobile/screens/rides_screen.dart';
import 'package:hajusput_mobile/screens/seat_selection_screen.dart';
import 'package:provider/provider.dart';

class EditRideScreen extends StatefulWidget {
  final Ride ride;

  EditRideScreen({required this.ride});

  @override
  _EditRideScreenState createState() => _EditRideScreenState();
}

class _EditRideScreenState extends State<EditRideScreen> {
  String? departureLocation;
  String? destinationLocation;

  @override
  void initState() {
    super.initState();
    _fetchLocationNames(
        widget.ride.departureLocationId, widget.ride.destinationLocationId);
  }

  Future<void> _fetchLocationNames(
      int departureLocationId, int destinationLocationId) async {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);

    final locationStart = await locationProvider.getById(departureLocationId);
    final locationEnd = await locationProvider.getById(destinationLocationId);

    setState(() {
      departureLocation = locationStart.city;
      destinationLocation = locationEnd.city;
    });
  }

  Future<void> _cancelRide() async {
    bool? confirmCancellation = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cancel Ride'),
        content: Text('Are you sure you want to cancel this ride?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
        ],
      ),
    );

    if (confirmCancellation == true) {
      try {
        final rideProvider = Provider.of<RideProvider>(context, listen: false);
        await rideProvider.cancelRide(widget.ride.rideId!);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ride cancelled successfully')),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => RidesScreen()),
          (route) => false,
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to cancel ride')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Ride'),
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: Text('Route: $departureLocation → $destinationLocation',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Location changes are not allowed.'),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: Text('Date: ${widget.ride.departureDate}'),
                trailing: Icon(Icons.edit, color: Colors.blueAccent),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DateTimeScreen(ride: widget.ride),
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      widget.ride.departureDate = result;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title:
                    Text('Seats: ${widget.ride.availableSeats ?? 'Not Set'}'),
                trailing: Icon(Icons.edit, color: Colors.blueAccent),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SeatSelectionScreen(ride: widget.ride),
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      widget.ride.availableSeats = result;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              child: ElevatedButton(
                onPressed: _cancelRide,
                child: Text('Cancel Ride', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
