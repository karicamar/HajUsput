import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hajusput_mobile/providers/booking_provider.dart';
import 'package:hajusput_mobile/providers/car_provider.dart';
import 'package:hajusput_mobile/providers/gender_provider.dart';
import 'package:hajusput_mobile/providers/location_provider.dart';
import 'package:hajusput_mobile/providers/message_provider.dart';
import 'package:hajusput_mobile/providers/payment_provider.dart';
import 'package:hajusput_mobile/providers/review_provider.dart';
import 'package:hajusput_mobile/providers/ride_provider.dart';
import 'package:hajusput_mobile/providers/user_provider.dart';
import 'package:hajusput_mobile/screens/inbox_screen.dart';
import 'package:hajusput_mobile/screens/login_screen.dart';
import 'package:hajusput_mobile/screens/profile_screen.dart';
import 'package:hajusput_mobile/screens/publish_screen.dart';
import 'package:hajusput_mobile/screens/rides_screen.dart';
import 'package:hajusput_mobile/screens/search_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISH_KEY'] ?? '';
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => GenderProvider()),
      ChangeNotifierProvider(create: (_) => RideProvider()),
      ChangeNotifierProvider(create: (_) => LocationProvider()),
      ChangeNotifierProvider(create: (_) => MessageProvider()),
      ChangeNotifierProvider(create: (_) => ReviewProvider()),
      ChangeNotifierProvider(create: (_) => BookingProvider()),
      ChangeNotifierProvider(create: (_) => PaymentProvider()),
      ChangeNotifierProvider(create: (_) => CarProvider()),
    ],
    child: MyApp(),
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
          //fontFamily: 'Montserrat',
          fontFamily: 'ClashGrotesk'),
      home: LoginScreen(),
      routes: {
        '/search': (context) => SearchScreen(),
        '/publish': (context) => PublishScreen(),
        '/rides': (context) => RidesScreen(),
        '/inbox': (context) => InboxScreen(),
        '/profile': (context) => ProfileScreen(),
      },
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
