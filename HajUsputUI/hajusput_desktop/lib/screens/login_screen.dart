import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:hajusput_desktop/screens/home_screen.dart';
import 'package:ionicons/ionicons.dart';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Widget inputField(String hint, IconData iconData){
    
    return Padding(padding: const EdgeInsets.all(16.0),
    
    child: SizedBox(
      height: 40,
      width: 300,
      child: Material(
        elevation: 8,
        shadowColor: Colors.black87,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        child: TextField(
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
          ),
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        prefixIcon: Icon(iconData),
            ),
          ),
      ),
   
      ),
    
    );
  
  }

  Widget loginButton(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      
      child: SizedBox(height: 40, width: 100,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
          MaterialPageRoute(
        builder: (context) => const HomeScreen(),
          ),
        );
        },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
             backgroundColor: Colors.lightBlue,
            shape: const StadiumBorder(),
            elevation: 8,
            shadowColor: Colors.black87,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
body: Stack(children: [
  //Image.network("https://e7.pngegg.com/pngimages/667/529/png-clipart-carpool-real-time-ridesharing-transport-passenger-car-driving-logo.png"),
  
  
  Center(
    child: Padding(
      padding: const EdgeInsets.only(top:100),
  
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          inputField('Userame', Ionicons.person_outline),
          inputField('Password',Ionicons.lock_closed_outline),
          loginButton('Login'),
        ],
      ),
    ),
  ),
  
],)

    );
  }
}
