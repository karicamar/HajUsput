import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/booking.dart';
import '../models/payment.dart'; // Ensure this import
import '../models/review.dart';
import '../models/ride.dart';
import '../providers/booking_provider.dart';
import '../providers/location_provider.dart';
import '../providers/payment_provider.dart'; // Ensure this import
import '../providers/user_provider.dart';
import '../providers/review_provider.dart';
import '../screens/edit_ride_screen.dart';
import '../screens/message_details_screen.dart';
import '../screens/payment_screen.dart'; // Ensure this import
import '../screens/leave_rating_screen.dart';
import '../utils/user_session.dart';
import '../utils/utils.dart';

class RideDetailsScreen extends StatefulWidget {
  final Ride ride;

  RideDetailsScreen({required this.ride});

  @override
  _RideDetailsScreenState createState() => _RideDetailsScreenState();
}

class _RideDetailsScreenState extends State<RideDetailsScreen> {
  String? driverName;
  double? driverRating;
  String? departureLocation;
  String? destinationLocation;
  Booking? _currentBooking;
  Review? _existingReview;
  bool _isLoading = false; // Added loading state

  @override
  void initState() {
    super.initState();
    _fetchRideDetails();
  }

  Future<void> _fetchRideDetails() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final reviewRatingProvider =
        Provider.of<ReviewProvider>(context, listen: false);
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);

    if (widget.ride.driverId != UserSession.userId) {
      final driver = await userProvider.getById(widget.ride.driverId!);
      final rating =
          await reviewRatingProvider.getDriverRating(widget.ride.driverId!);
      setState(() {
        driverName = '${driver.firstName} ${driver.lastName}';
        driverRating = rating;
      });
    }

    final locationStart =
        await locationProvider.getById(widget.ride.departureLocationId);
    final locationEnd =
        await locationProvider.getById(widget.ride.destinationLocationId);
    setState(() {
      departureLocation = locationStart.city;
      destinationLocation = locationEnd.city;
    });

    try {
      final booking = await bookingProvider.getByRideId(widget.ride.rideId!);
      setState(() {
        _currentBooking = booking;
      });
      final review = await reviewRatingProvider.getReviewByUser(
          UserSession.userId!,
          booking.passengerId ?? widget.ride.driverId!,
          widget.ride.rideId!);
      setState(() {
        _existingReview = review;
      });
    } catch (_) {
      setState(() {
        _currentBooking = null;
      });
    }
  }

  Future<void> _bookRide(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final bookingProvider =
          Provider.of<BookingProvider>(context, listen: false);
      final bookedRide = Booking(
        null,
        widget.ride.rideId,
        UserSession.userId,
        "Pending",
        DateTime.now(),
        null,
      );
      final booking = await bookingProvider.insert(bookedRide);

      final paymentProvider =
          Provider.of<PaymentProvider>(context, listen: false);
      final payment = Payment(
        null,
        widget.ride.rideId,
        UserSession.userId,
        "Pending",
        DateTime.now(),
        widget.ride.price!.toDouble(),
        "Not Set",
      );
      final createdPayment = await paymentProvider.insert(payment);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking successful!')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentScreen(
            bookingId: booking.bookingId!,
            payment: createdPayment,
          ),
        ),
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to book ride: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToLeaveRating() {
    final loggedInUserId = UserSession.userId;
    final isDriver = widget.ride.driverId == loggedInUserId;

    if (isDriver) {
      if (_currentBooking?.passengerId != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LeaveRatingScreen(
              userId: _currentBooking!.passengerId!,
              userName: 'Passenger',
              existingReview: _existingReview,
              rideId: widget.ride.rideId!,
            ),
          ),
        );
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LeaveRatingScreen(
            userId: widget.ride.driverId!,
            userName: driverName?.split(' ')[0] ?? 'Driver',
            existingReview: _existingReview,
            rideId: widget.ride.rideId!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loggedInUserId = UserSession.userId;
    final isDriver = widget.ride.driverId == loggedInUserId;
    final isArchived = widget.ride.rideStatus == 'Archived';
    final isCancelled = widget.ride.rideStatus == 'Cancelled';
    final isBookingCompleted = _currentBooking?.bookingStatus == 'Completed';

    return Scaffold(
      appBar: AppBar(
        title: Text('Ride Details'),
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow(Icons.location_on, 'Departure:', departureLocation),
              _buildInfoRow(Icons.flag, 'Destination:', destinationLocation),
              _buildInfoRow(
                  Icons.date_range,
                  'Departure Date:',
                  formatDate(widget.ride.departureDate) +
                      ', ' +
                      formatTime(widget.ride.departureDate)),
              _buildInfoRow(Icons.euro, 'Price:',
                  '${widget.ride.price?.toStringAsFixed(2)}'),
              _buildInfoRow(Icons.event_seat, 'Seats Available:',
                  '${widget.ride.availableSeats}'),
              SizedBox(height: 20),
              if (isArchived && isBookingCompleted)
                _buildActionButton(
                    context,
                    _existingReview == null ? 'Leave a Rating' : 'Edit Rating',
                    Icons.rate_review,
                    _navigateToLeaveRating),
              if (!isDriver && !isArchived) ...[
                if (driverName != null)
                  _buildInfoRow(Icons.person, 'Driver:', driverName),
                if (driverRating != null)
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.green.shade600),
                      SizedBox(width: 10),
                      Text('Driver Rating:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(width: 10),
                      Text(driverRating!.toStringAsFixed(1),
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                _buildActionButton(context, 'Contact Driver', Icons.message,
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessageDetailsScreen(
                            userId: widget.ride.driverId!,
                            name: driverName ?? 'Driver'),
                      ));
                }),
                SizedBox(height: 10),
                if (_currentBooking == null)
                  _buildActionButton(
                    context,
                    'Book Ride',
                    Icons.event_available,
                    () => _bookRide(context),
                    isLoading: _isLoading,
                  ),
              ],
              if (isDriver && !isArchived && !isCancelled)
                _buildActionButton(context, 'Edit Ride', Icons.edit, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditRideScreen(ride: widget.ride),
                      ));
                }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green.shade600),
          SizedBox(width: 10),
          Text(label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(width: 10),
          Expanded(
              child:
                  Text(value ?? 'Loading...', style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback? onPressed, {
    bool isLoading = false,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: isLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Icon(icon),
      label: Text(label, style: TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green.shade300,
      ),
    );
  }
}
