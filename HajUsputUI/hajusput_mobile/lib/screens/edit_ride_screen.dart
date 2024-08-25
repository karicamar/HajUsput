import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hajusput_mobile/models/ride.dart';
import 'package:hajusput_mobile/providers/location_provider.dart';
import 'package:hajusput_mobile/screens/date_time_screen.dart';
import 'package:hajusput_mobile/screens/seat_selection_screen.dart';
import 'package:provider/provider.dart';

class EditRideScreen extends StatefulWidget {
  final Ride ride;

  EditRideScreen({required this.ride});

  @override
  _EditRideScreenState createState() => _EditRideScreenState();
}

class _EditRideScreenState extends State<EditRideScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
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
    // Implement ride cancellation logic here
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
      // Perform cancellation and pop the screen
      Navigator.pop(context, {'cancelled': true});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Ride'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              ListTile(
                title:
                    Text('Route: $departureLocation to $destinationLocation '),
                subtitle: Text('Location changes are not allowed.'),
              ),
              ListTile(
                title: Text('Date: ${widget.ride.departureDate}'),
                trailing: Icon(Icons.edit),
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
              ListTile(
                title:
                    Text('Seats: ${widget.ride.availableSeats ?? 'Not Set'}'),
                trailing: Icon(Icons.edit),
                onTap: () async {
                  // Navigate to SeatSelectionScreen for editing seats
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
              Spacer(),
              ElevatedButton(
                onPressed: _cancelRide,
                child: Text('Cancel Ride'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
