import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/booking.dart';
import '../models/payment.dart';
import '../models/ride.dart';
import '../providers/booking_provider.dart';
import '../providers/location_provider.dart';
import '../providers/payment_provider.dart';
import '../providers/user_provider.dart';
import '../providers/review_provider.dart';
import '../screens/edit_ride_screen.dart';
import '../screens/message_details_screen.dart';
import '../screens/payment_screen.dart';
import '../screens/ratings_screen.dart';
import '../screens/leave_rating_screen.dart'; // Import the new screen
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
  final BookingProvider _bookingProvider = BookingProvider();
  bool _isLoading = false;
  Booking? _currentBooking; // To store the current booking

  @override
  void initState() {
    super.initState();

    // Fetch driver details only if the driver is not the logged-in user
    if (widget.ride.driverId != UserSession.userId) {
      _fetchDriverDetailsAndRating(widget.ride.driverId);
    }

    _fetchLocationNames(
      widget.ride.departureLocationId,
      widget.ride.destinationLocationId,
    );

    _fetchCurrentBooking(); // Fetch the current booking details
  }

  Future<void> _fetchDriverDetailsAndRating(int? driverId) async {
    if (driverId == null) return;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final reviewRatingProvider =
        Provider.of<ReviewProvider>(context, listen: false);

    final driver = await userProvider.getById(driverId);
    final rating = await reviewRatingProvider.getDriverRating(driverId);

    setState(() {
      driverName = '${driver.firstName} ${driver.lastName}';
      driverRating = rating;
    });
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

  Future<void> _fetchCurrentBooking() async {
    try {
      final booking = await _bookingProvider.getByRideId(widget.ride.rideId!);
      setState(() {
        _currentBooking = booking;
      });
    } catch (error) {
      // Handle errors, e.g., booking not found
      setState(() {
        _currentBooking = null;
      });
    }
  }

  Future<void> _bookRide(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    final bookedRide = Booking(
      null,
      widget.ride.rideId,
      UserSession.userId,
      "Pending",
      DateTime.now(),
      null,
    );

    try {
      final booking = await _bookingProvider.insert(bookedRide);

      final payment = Payment(
        null,
        widget.ride.rideId,
        UserSession.userId,
        "Pending",
        DateTime.now(),
        widget.ride.price!.toDouble(),
        "Not Set",
      );
      final PaymentProvider paymentProvider = PaymentProvider();
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

  void _navigateToLeaveRating() async {
    final loggedInUserId = UserSession.userId;
    final isDriver = widget.ride.driverId == loggedInUserId;

    if (isDriver) {
      // Fetch the booking to get the passenger details
      final booking = await _bookingProvider.getByRideId(widget.ride.rideId!);
      final passengerId = booking.passengerId;

      if (passengerId != null) {
        // Fetch passenger details (optional, if needed)
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final passenger = await userProvider.getById(passengerId);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LeaveRatingScreen(
              userId: passengerId,
              userName: passenger.firstName,
            ),
          ),
        );
      } else {
        // Handle case where passengerId is not available
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passenger details not available')),
        );
      }
    } else {
      // Not the driver, send the driver details
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LeaveRatingScreen(
            userId: widget.ride.driverId!,
            userName: driverName?.split(' ')[0] ?? 'Driver',
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
    final isBookingConfirmed = _currentBooking?.bookingStatus == 'Confirmed';

    return Scaffold(
      appBar: AppBar(
        title: Text('Ride Details'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green.shade300,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow(
                Icons.location_on,
                'Departure:',
                departureLocation,
              ),
              _buildInfoRow(
                Icons.flag,
                'Destination:',
                destinationLocation,
              ),
              _buildInfoRow(
                Icons.date_range,
                'Departure Date:',
                formatDate(widget.ride.departureDate) +
                    ', ' +
                    formatTime(widget.ride.departureDate),
              ),
              _buildInfoRow(
                Icons.euro,
                'Price:',
                '${widget.ride.price?.toStringAsFixed(2)}',
              ),
              _buildInfoRow(
                Icons.event_seat,
                'Seats Available:',
                '${widget.ride.availableSeats}',
              ),
              SizedBox(height: 20),
              // Conditional rendering based on ride status and booking status
              if (isArchived && !isBookingConfirmed) ...[
                // Only show ride details, no buttons
              ] else if (isArchived) ...[
                _buildActionButton(
                  context,
                  'Leave a Rating',
                  Icons.rate_review,
                  _navigateToLeaveRating,
                ),
              ] else if (!isDriver) ...[
                if (driverName != null)
                  _buildInfoRow(Icons.person, 'Driver:', driverName),
                if (driverRating != null)
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.green.shade600),
                      SizedBox(width: 10),
                      Text(
                        'Driver Rating:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        driverRating!.toStringAsFixed(1),
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.info_outline,
                          color: Colors.green.shade600,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RatingsScreen(
                                userId: widget.ride.driverId!,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                _buildActionButton(
                  context,
                  'Contact Driver',
                  Icons.message,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessageDetailsScreen(
                          userId: widget.ride.driverId!,
                          name: driverName?.split(' ')[0] ?? 'Driver',
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                _buildActionButton(
                  context,
                  'Book Ride',
                  Icons.event_available,
                  () => _bookRide(context),
                  isLoading: _isLoading,
                ),
              ] else if (isDriver) ...[
                _buildActionButton(
                  context,
                  'Edit Ride',
                  Icons.edit,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditRideScreen(ride: widget.ride),
                      ),
                    );
                  },
                ),
              ],
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
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value ?? 'Loading...',
              style: TextStyle(fontSize: 16),
            ),
          ),
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
      label: Text(
        label,
        style: TextStyle(fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green.shade300,
      ),
    );
  }
}
