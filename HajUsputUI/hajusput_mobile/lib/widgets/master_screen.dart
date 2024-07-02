
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
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      drawer: NavigationDrawerScreen(),
      body: widget.body,
    );
}
}
