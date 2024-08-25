import 'package:flutter/material.dart';
import 'package:hajusput_desktop/models/booking.dart';
import 'package:hajusput_desktop/models/ride.dart';
import 'package:hajusput_desktop/models/user.dart';
import 'package:hajusput_desktop/providers/booking_provider.dart';
import 'package:hajusput_desktop/providers/payment_provider.dart';
import 'package:hajusput_desktop/providers/user_provider.dart';
import 'package:provider/provider.dart';

class RideDetailsScreen extends StatelessWidget {
  final Ride ride;

  RideDetailsScreen({required this.ride});

  @override
  Widget build(BuildContext context) {
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    final paymentProvider =
        Provider.of<PaymentProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ride Details: ${ride.rideId}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ride Information Section
            _buildRideInfoSection(context),
            SizedBox(height: 20),
            // Driver Information Section
            _buildDriverInfoSection(userProvider),
            SizedBox(height: 20),
            // Bookings Section
            _buildBookingsSection(bookingProvider, paymentProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildRideInfoSection(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ride Information',
                style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10),
            Text('Departure: ${ride.departureLocationId}'),
            Text('Destination: ${ride.destinationLocationId}'),
            Text('Departure Date: ${ride.departureDate}'),
            Text('Status: ${ride.rideStatus}'),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverInfoSection(UserProvider userProvider) {
    return FutureBuilder(
      future: userProvider.getById(ride.driverId!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return _buildErrorText('Error loading driver details');
        } else if (!snapshot.hasData) {
          return _buildErrorText('No driver information available');
        }

        final driver = snapshot.data as User;
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Driver Information',
                    style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 10),
                Text('Driver: ${driver.username}'),
                Text('Email: ${driver.email}'),
                // Add more driver details if needed
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBookingsSection(
      BookingProvider bookingProvider, PaymentProvider paymentProvider) {
    return FutureBuilder(
      future: bookingProvider.getRideBookings(ride.rideId!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return _buildErrorText('Error loading bookings');
        } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
          return _buildErrorText('No bookings available');
        }

        final bookings = snapshot.data as List<Booking>;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: bookings.map((booking) {
            return _buildBookingCard(booking, paymentProvider);
          }).toList(),
        );
      },
    );
  }

  Widget _buildBookingCard(Booking booking, PaymentProvider paymentProvider) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Booking ID: ${booking.bookingId}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Status: ${booking.bookingStatus}'),
            SizedBox(height: 10),
            if (booking.paymentId != null)
              FutureBuilder(
                future: paymentProvider.getById(booking.paymentId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error loading payment details');
                  } else if (snapshot.hasData) {
                    return _buildPaymentDetails(snapshot.data);
                  } else {
                    return Text('Payment details not available');
                  }
                },
              )
            else
              Text(
                  'Payment information not available'), // Handle the null case here
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetails(dynamic payment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Status: ${payment.status}'),
        Text('Payment Method: ${payment.method}'),
        Text('Payment Date: ${payment.date}'),
        // Add more payment details if needed
      ],
    );
  }

  Widget _buildErrorText(String message) {
    return Text(message, style: TextStyle(color: Colors.red));
  }
}
