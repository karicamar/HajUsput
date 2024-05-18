
import 'package:flutter/material.dart';

import '../widgets/master_screen.dart';



class RidesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Rides',
      body: Center(child: Text('Rides Content')),
    );
  }
}
