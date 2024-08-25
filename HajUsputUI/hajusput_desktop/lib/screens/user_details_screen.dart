import 'package:flutter/material.dart';
import 'package:hajusput_desktop/models/user.dart';

class UserDetailsScreen extends StatelessWidget {
  final User user;

  UserDetailsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lastName}'),
      ),
      body: DefaultTabController(
        length: 5, // Number of tabs
        child: Column(
          children: <Widget>[
            TabBar(
              tabs: [
                Tab(icon: Icon(Icons.payment), text: "Payments"),
                Tab(icon: Icon(Icons.book_online), text: "Bookings"),
                Tab(icon: Icon(Icons.directions_car), text: "Rides"),
                Tab(icon: Icon(Icons.car_rental), text: "Cars"),
                Tab(icon: Icon(Icons.star), text: "Reviews"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // UserPaymentsTab(userId: user.userId), // Implement this widget
                  // UserBookingsTab(userId: user.userId), // Implement this widget
                  // UserRidesTab(userId: user.userId), // Implement this widget
                  // UserCarsTab(userId: user.userId), // Implement this widget
                  // UserReviewsTab(userId: user.userId), // Implement this widget
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
