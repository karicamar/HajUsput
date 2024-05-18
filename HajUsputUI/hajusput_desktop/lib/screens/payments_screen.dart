import 'package:flutter/material.dart';

import '../widgets/master_screen.dart';


class PaymentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Payments',
      body: Center(child: Text('Payments Content')),
    );
  }
}
