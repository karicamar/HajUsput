import 'package:flutter/material.dart';
import 'package:hajusput_desktop/models/booking.dart';
import 'package:hajusput_desktop/models/ride.dart';
import 'package:hajusput_desktop/models/user.dart';
import 'package:hajusput_desktop/providers/booking_provider.dart';
import 'package:hajusput_desktop/providers/location_provider.dart';
import 'package:hajusput_desktop/providers/payment_provider.dart';
import 'package:hajusput_desktop/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/master_screen.dart';

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
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);

    return MasterScreen(
      title: 'Ride Details: ${ride.rideId} ',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRideInfoSection(context, locationProvider),
            SizedBox(height: 16),
            _buildDriverInfoSection(userProvider),
            SizedBox(height: 16),
            _buildBookingsSection(bookingProvider, paymentProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildRideInfoSection(
      BuildContext context, LocationProvider locationProvider) {
    return _buildCard(
      context,
      title: 'Ride Information',
      children: [
        // Use FutureBuilder only for Departure city and Destination city
        FutureBuilder<String>(
          future:
              _fetchLocationName(ride.departureLocationId, locationProvider),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildInfoRow('Departure:', 'Loading...');
            } else if (snapshot.hasError) {
              return _buildInfoRow('Departure:', 'Error loading location');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return _buildInfoRow('Departure:', 'Location not found');
            }
            return _buildInfoRow(
                'Departure:', snapshot.data!); // Display the city name
          },
        ),
        FutureBuilder<String>(
          future:
              _fetchLocationName(ride.destinationLocationId, locationProvider),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildInfoRow('Destination:', 'Loading...');
            } else if (snapshot.hasError) {
              return _buildInfoRow('Destination:', 'Error loading location');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return _buildInfoRow('Destination:', 'Location not found');
            }
            return _buildInfoRow(
                'Destination:', snapshot.data!); // Display the city name
          },
        ),

        _buildInfoRow('Departure Date:', ride.departureDate.toString()),
        _buildInfoRow('Status:', ride.rideStatus!),
      ],
    );
  }

  Future<String> _fetchLocationName(
      int locationId, LocationProvider locationProvider) async {
    final locationResult = await locationProvider.getById(locationId);
    return locationResult.city;
  }

  Widget _buildDriverInfoSection(UserProvider userProvider) {
    return FutureBuilder(
      future: userProvider.getById(ride.driverId!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || !snapshot.hasData) {
          return _buildCard(context, title: 'Driver Information', children: [
            Text('Error loading driver details',
                style: TextStyle(color: Colors.red))
          ]);
        }

        final driver = snapshot.data as User;
        return _buildCard(
          context,
          title: 'Driver Information',
          children: [
            _buildInfoRow('Driver:', driver.username!),
            _buildInfoRow('Email:', driver.email!),
          ],
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
        } else if (snapshot.hasError ||
            !snapshot.hasData ||
            (snapshot.data as List).isEmpty) {
          return _buildCard(context, title: 'Bookings', children: [
            Text('No bookings available', style: TextStyle(color: Colors.red))
          ]);
        }

        final bookings = snapshot.data as List<Booking>;
        return _buildCard(
          context,
          title: 'Bookings',
          children: bookings
              .map((booking) => _buildBookingCard(booking, paymentProvider))
              .toList(),
        );
      },
    );
  }

  Widget _buildBookingCard(Booking booking, PaymentProvider paymentProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        _buildInfoRow('Booking ID:', booking.bookingId.toString()),
        _buildInfoRow('Status:', booking.bookingStatus!),
        if (booking.paymentId != null)
          FutureBuilder(
            future: paymentProvider.getById(booking.paymentId!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || !snapshot.hasData) {
                return Text('Payment details not available',
                    style: TextStyle(color: Colors.red));
              }
              return _buildPaymentDetails(snapshot.data);
            },
          ),
      ],
    );
  }

  Widget _buildPaymentDetails(dynamic payment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('Payment Status:', payment.paymentStatus),
        _buildInfoRow('Payment Method:', payment.paymentMethod),
        _buildInfoRow('Payment Date:', payment.paymentDate.toString()),
      ],
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title, required List<Widget> children}) {
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
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }
}
