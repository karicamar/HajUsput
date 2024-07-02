import 'package:flutter/material.dart';
import 'package:hajusput_mobile/providers/gender_provider.dart';
import 'package:hajusput_mobile/providers/user_provider.dart';
import 'package:hajusput_mobile/screens/login_screen.dart';
import 'package:hajusput_mobile/utils/utils.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => GenderProvider()),
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
        useMaterial3: false,
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
