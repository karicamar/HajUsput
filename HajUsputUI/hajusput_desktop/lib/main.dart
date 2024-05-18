import 'package:flutter/material.dart';
import 'package:hajusput_desktop/providers/user_provider.dart';
import 'package:hajusput_desktop/screens/login_screen.dart';
import 'package:hajusput_desktop/utils/utils.dart';
import 'package:provider/provider.dart';

void main() {
   runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      //ChangeNotifierProvider(create: (_) => JediniceMjereProvider()),
      //ChangeNotifierProvider(create: (_) => VrsteProizvodaProvider()),
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
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: kPrimaryColor,
              fontFamily: 'Montserrat',
            ),
      ),
      home: const LoginScreen(),
    );
  }
}


