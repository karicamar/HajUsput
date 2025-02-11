import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hajusput_desktop/providers/booking_provider.dart';
import 'package:hajusput_desktop/providers/carmake_provider.dart';
import 'package:hajusput_desktop/providers/gender_provider.dart';
import 'package:hajusput_desktop/providers/location_provider.dart';
import 'package:hajusput_desktop/providers/payment_provider.dart';
import 'package:hajusput_desktop/providers/ride_provider.dart';
import 'package:hajusput_desktop/providers/role_provider.dart';
import 'package:hajusput_desktop/providers/user_provider.dart';
import 'package:hajusput_desktop/providers/user_role_provider.dart';
import 'package:hajusput_desktop/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => GenderProvider()),
      ChangeNotifierProvider(create: (_) => RideProvider()),
      ChangeNotifierProvider(create: (_) => PaymentProvider()),
      ChangeNotifierProvider(create: (_) => LocationProvider()),
      ChangeNotifierProvider(create: (_) => BookingProvider()),
      ChangeNotifierProvider(create: (_) => RoleProvider()),
      ChangeNotifierProvider(create: (_) => UserRoleProvider()),
      ChangeNotifierProvider(create: (_) => CarMakeProvider()),
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
          primaryColor: Colors.green[
              900], // Change the default purple to blue, or any color you want

          // Optionally set the accent color and other related settings
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(
            secondary: Colors.green[
                700], // Change the default purple to blue, or any color you wantYou can change this to a different color
          ),

          //fontFamily: 'Montserrat',
          fontFamily: 'ClashGrotesk'),
      home: const LoginScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
