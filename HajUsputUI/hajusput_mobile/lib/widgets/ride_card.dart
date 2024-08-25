import 'package:flutter/material.dart';
import 'package:hajusput_mobile/models/ride.dart';

class RideCard extends StatelessWidget {
  final Ride ride;
  final bool showIcon;

  const RideCard({Key? key, required this.ride, this.showIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: showIcon ? Icon(Icons.cancel, color: Colors.red) : null,
        title: Text('Ride to ${ride.destinationLocationId}'),
        subtitle: Text('Date: ${ride.departureDate}'),
        trailing: Text('${ride.availableSeats} seats'),
        onTap: () {
          // Handle ride tap
        },
      ),
    );
  }
}
