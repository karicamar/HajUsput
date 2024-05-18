import 'package:flutter/material.dart';

import '../widgets/master_screen.dart';



class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Reports',
      body: Center(child: Text('Reports Content')),
    );
  }
}
