import 'package:flutter/material.dart';

class RideCard extends StatelessWidget {
  final String departureLocation;
  final String destinationLocation;
  final DateTime rideDate;
  final int availableSeats;
  final double price;
  final Function onTap;

  RideCard({
    required this.departureLocation,
    required this.destinationLocation,
    required this.rideDate,
    required this.availableSeats,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('$departureLocation → $destinationLocation'),
        subtitle: Text('Date: ${rideDate.toLocal()} | Seats: $availableSeats'),
        trailing: Text('\$$price'),
        onTap: () => onTap(),
      ),
    );
  }
}
