import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
    
    child:Column(children: [
    Text("data"),
    SizedBox(height: 20,),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },child: Text("Back"))
  ]),
  );
}
}
