import 'package:flutter/material.dart';
import 'package:hajusput_mobile/models/ride.dart';
import 'package:hajusput_mobile/providers/location_provider.dart';
import 'package:hajusput_mobile/providers/ride_provider.dart';
import 'package:hajusput_mobile/screens/confirmation_screen.dart';
import 'package:provider/provider.dart';

class PriceScreen extends StatefulWidget {
  final Ride ride;

  PriceScreen({required this.ride});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  int _predictedPrice = 0; // Default value
  int _adjustedPrice = 0; // Default value
  final RideProvider _rideProvider = RideProvider();
  String? departureLocation;
  String? destinationLocation;

  @override
  void initState() {
    super.initState();
    _fetchLocationNames(
        widget.ride.departureLocationId, widget.ride.destinationLocationId);
    _predictPrice();
  }

  Future<void> _predictPrice() async {
    try {
      final price = await _rideProvider.predictPrice(
        departureLocation,
        destinationLocation,
        widget.ride.distance,
        widget.ride.duration,
        widget.ride.availableSeats,
      );
      setState(() {
        _predictedPrice = price.round();
        _adjustedPrice = _predictedPrice;
      });
    } catch (error) {
      print('Error predicting price: $error');
    }
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

  void _adjustPrice(int adjustment) {
    final int minPrice = (_predictedPrice * 0.8).round();
    final int maxPrice = (_predictedPrice * 1.2).round();
    setState(() {
      _adjustedPrice = (_adjustedPrice + adjustment).clamp(minPrice, maxPrice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Price'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _predictedPrice > 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "What is your price per seat?",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.grey),
                        onPressed: () => _adjustPrice(-1),
                      ),
                      SizedBox(width: 16.0),
                      Text(
                        '$_adjustedPrice',
                        style: TextStyle(
                            fontSize: 36.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 16.0),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.grey),
                        onPressed: () => _adjustPrice(1),
                      ),
                    ],
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20.0),
                    Text('Calculating price...'),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.ride.price = _adjustedPrice;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmationScreen(
                ride: widget.ride,
              ),
            ),
          );
        },
        child: Icon(Icons.check),
        tooltip: 'Confirm Price',
      ),
    );
  }
}
