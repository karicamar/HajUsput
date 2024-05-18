import 'package:flutter/material.dart';

import '../widgets/master_screen.dart';



class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Settings',
      body: Center(child: Text('Settings Content')),
    );
  }
}
