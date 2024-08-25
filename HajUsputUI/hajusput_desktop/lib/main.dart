import 'package:flutter/material.dart';
import 'package:hajusput_desktop/providers/booking_provider.dart';
import 'package:hajusput_desktop/providers/gender_provider.dart';
import 'package:hajusput_desktop/providers/location_provider.dart';
import 'package:hajusput_desktop/providers/payment_provider.dart';
import 'package:hajusput_desktop/providers/ride_provider.dart';
import 'package:hajusput_desktop/providers/user_provider.dart';
import 'package:hajusput_desktop/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => GenderProvider()),
      ChangeNotifierProvider(create: (_) => RideProvider()),
      ChangeNotifierProvider(create: (_) => PaymentProvider()),
      ChangeNotifierProvider(create: (_) => LocationProvider()),
      ChangeNotifierProvider(create: (_) => BookingProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haj Usput!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
        //fontFamily: 'ClashGrotesk'
      ),
      home: const LoginScreen(),
    );
  }
}
