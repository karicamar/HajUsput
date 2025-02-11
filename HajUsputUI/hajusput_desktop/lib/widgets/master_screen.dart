import 'package:flutter/material.dart';
import '../screens/navigation_drawer.dart';

class MasterScreen extends StatefulWidget {
  final String title;
  final Widget body;

  MasterScreen({required this.title, required this.body});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          if (Navigator.of(context)
              .canPop()) // Show back button only if possible
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
      drawer: NavigationDrawerScreen(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 255, 255, 255),
              Colors.green.shade600
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: widget.body, // Ensures the content is rendered properly
      ),
    );
  }
}
