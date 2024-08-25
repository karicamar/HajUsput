import 'package:flutter/material.dart';
import 'package:hajusput_mobile/models/ride.dart';
import 'package:hajusput_mobile/providers/ride_provider.dart';
import 'package:hajusput_mobile/screens/price_screen.dart';
import 'package:provider/provider.dart';

class SeatSelectionScreen extends StatefulWidget {
  final Ride ride;

  SeatSelectionScreen({
    required this.ride,
  });

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  int _selectedSeats = 3; // Default value
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Ensure the loading state is reset when the screen is initialized
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Seats'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_isLoading) ...[
                  Text(
                    "How many passengers can you take?",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            if (_selectedSeats > 1) {
                              _selectedSeats--;
                            }
                          });
                        },
                      ),
                      SizedBox(width: 16.0),
                      Text(
                        '$_selectedSeats',
                        style: TextStyle(fontSize: 24.0),
                      ),
                      SizedBox(width: 16.0),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            if (_selectedSeats < 4) {
                              _selectedSeats++;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                ]
              ],
            ),
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(), // Show loader if loading
              ),
          ],
        ),
      ),
      floatingActionButton: !_isLoading
          ? FloatingActionButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true; // Show the loader and hide the button
                });

                widget.ride.availableSeats = _selectedSeats;
                print('Selected seats: ${widget.ride.availableSeats}');

                if (widget.ride.rideId == null) {
                  // Navigate to PriceScreen for new ride creation
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PriceScreen(
                        ride: widget.ride,
                      ),
                    ),
                  ).then((_) {
                    setState(() {
                      _isLoading =
                          false; // Reset loading state when coming back
                    });
                  });
                } else {
                  try {
                    final rideProvider =
                        Provider.of<RideProvider>(context, listen: false);

                    // Await the update operation to ensure it's completed
                    await rideProvider.update(widget.ride.rideId!, widget.ride);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Ride updated successfully!')),
                    );

                    // Pop the screen and return the updated ride
                    Navigator.pop(context, widget.ride.availableSeats);
                  } catch (e) {
                    // Handle errors, possibly with a more user-friendly message
                    print('Failed to update ride: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Failed to update ride. Please try again.')),
                    );
                  } finally {
                    setState(() {
                      _isLoading = false; // Hide the loader after the process
                    });
                  }
                }
              },
              child: Icon(Icons.check),
              tooltip: 'Confirm Seats',
            )
          : null,
    );
  }
}
