import 'package:flutter/material.dart';
import 'package:hajusput_mobile/models/ride.dart';
import 'package:hajusput_mobile/providers/ride_provider.dart';
import 'package:hajusput_mobile/screens/rides_screen.dart';
import 'package:hajusput_mobile/utils/user_session.dart';
import 'package:hajusput_mobile/utils/utils.dart';

class ConfirmationScreen extends StatefulWidget {
  final Ride ride;

  ConfirmationScreen({required this.ride});

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  bool _isLoading = false;
  final RideProvider _rideProvider = RideProvider();

  Future<void> _confirmRide(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final updatedRide = Ride(
        widget.ride.rideId ?? 0,
        UserSession.userId,
        widget.ride.departureLocationId,
        widget.ride.destinationLocationId,
        widget.ride.departureDate,
        widget.ride.distance,
        widget.ride.duration,
        widget.ride.availableSeats,
        'Scheduled',
        widget.ride.price,
      );

      await _rideProvider.insert(updatedRide);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ride added successfully!')),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => RidesScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      print('Error confirming ride: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add a new ride. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation'),
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, 'Confirm Your Ride'),
                  SizedBox(height: 20.0),
                  _buildInfoRow(
                      Icons.date_range,
                      'Departure Date:',
                      formatDate(widget.ride.departureDate) +
                          ', ' +
                          formatTime(widget.ride.departureDate)),
                  _buildInfoRow(Icons.directions_car, 'Distance:',
                      '${widget.ride.distance?.toStringAsFixed(2)} km'),
                  _buildInfoRow(Icons.timer, 'Duration:',
                      formatDuration(widget.ride.duration!)),
                  _buildInfoRow(Icons.event_seat, 'Available Seats:',
                      '${widget.ride.availableSeats}'),
                  _buildInfoRow(Icons.euro, 'Price:',
                      '${widget.ride.price?.toStringAsFixed(2)}'),
                  SizedBox(height: 20.0),
                  _buildConfirmButton(context),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.green.shade700,
          ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green.shade600),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _isLoading ? null : () => _confirmRide(context),
      icon: _isLoading
          ? CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            )
          : Icon(Icons.check_circle),
      label: Text('Confirm Ride', style: TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.white,
      ),
    );
  }
}
