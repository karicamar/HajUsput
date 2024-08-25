import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hajusput_mobile/models/payment.dart';
import 'package:hajusput_mobile/providers/payment_provider.dart';
import 'package:hajusput_mobile/providers/booking_provider.dart';
import 'package:hajusput_mobile/providers/ride_provider.dart';
import 'package:hajusput_mobile/screens/rides_screen.dart';

class PaymentScreen extends StatefulWidget {
  final int bookingId;
  final Payment payment;

  PaymentScreen({required this.bookingId, required this.payment});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final PaymentProvider _paymentProvider = PaymentProvider();
  final BookingProvider _bookingProvider = BookingProvider();
  final RideProvider _rideProvider = RideProvider();

  Future<void> _processStripePayment(BuildContext context) async {
    try {
      // Step 1: Create a PaymentIntent on the backend
      final paymentIntent =
          await _paymentProvider.createPaymentIntent(widget.payment.amount!);
      print('PaymentIntent response: ${paymentIntent['clientSecret']}');
      if (paymentIntent['clientSecret'] == null) {
        throw Exception('Client secret not found in payment intent response');
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['clientSecret'],
          merchantDisplayName: 'Haj Usput!',
        ),
      );
      await Stripe.instance.presentPaymentSheet();

      await _updatePaymentAndBooking('Stripe');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment successful!')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => RidesScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      print('Error during payment confirmation: $error');
      await _paymentProvider.failPayment(widget.payment.paymentId!);
      await _bookingProvider.cancelBooking(widget.bookingId);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed: $error')),
      );
    }
  }

  Future<void> _processCashPayment(BuildContext context) async {
    try {
      // Step 3: Update Payment and Booking
      await _updatePaymentAndBooking('Cash');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cash payment marked as complete!')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => RidesScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      print('Error during cash payment processing: $error');
      await _paymentProvider.failPayment(widget.payment.paymentId!);
      await _bookingProvider.cancelBooking(widget.bookingId);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cash payment failed: $error')),
      );
    }
  }

  Future<void> _updatePaymentAndBooking(String paymentMethod) async {
    // Step 1: Update the Payment method
    await _paymentProvider.update(
      widget.payment.paymentId!,
      {
        "paymentMethod": paymentMethod,
      },
    );

    // Step 2: Update the Booking with the paymentId
    await _bookingProvider.update(
      widget.bookingId,
      {
        "paymentId": widget.payment.paymentId!,
      },
    );
    await _paymentProvider.confirmPayment(widget.payment.paymentId!);
    await _bookingProvider.confirmBooking(widget.bookingId);
    // Step 3: Reduce the number of seats available in the ride
    await _rideProvider.reduceSeats(widget.payment.rideId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose how to pay:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            _buildPaymentButton(
              'Pay with Stripe',
              'assets/images/stripe.png',
              _processStripePayment,
            ),
            SizedBox(height: 20),
            _buildPaymentButton(
              'Pay with Cash',
              'assets/images/cash.png', // You can use an appropriate image for Cash or leave as is
              _processCashPayment,
              color: Colors.grey.shade200,
              textColor: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentButton(
    String text,
    String assetPath,
    Future<void> Function(BuildContext) onPressed, {
    Color color = Colors.white,
    Color textColor = Colors.black,
  }) {
    return material.Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () => onPressed(context),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                assetPath,
                height: 40, // Adjust the height as needed
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              SizedBox(width: 10), // To add some spacing after text
              Icon(
                Icons.arrow_forward_ios,
                color: textColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
