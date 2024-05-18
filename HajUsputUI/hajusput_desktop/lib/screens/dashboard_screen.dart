import 'package:flutter/material.dart';

import '../widgets/master_screen.dart';


class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Dashboard',
      body: Center(child: Text('Dash Content')),
    );
  }
}

// class DashboardContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             'Total Rides: 1000',
//             style: TextStyle(fontSize: 24),
//           ),
//           SizedBox(height: 20),
//           Text(
//             'Active Users: 500',
//             style: TextStyle(fontSize: 24),
//           ),
//           SizedBox(height: 20),
//           Text(
//             'Revenue: \$5000',
//             style: TextStyle(fontSize: 24),
//           ),
//           // Add more dashboard metrics as needed
//         ],
//       ),
//     );
//   }
// }