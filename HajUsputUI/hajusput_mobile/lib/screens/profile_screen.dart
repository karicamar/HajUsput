import 'package:flutter/material.dart';
import 'package:hajusput_mobile/models/user.dart';
import 'package:hajusput_mobile/screens/car_screen.dart';
import 'package:hajusput_mobile/screens/change_password_screen.dart';
import 'package:hajusput_mobile/screens/edit_details_screen.dart';
import 'package:hajusput_mobile/screens/login_screen.dart';
import 'package:hajusput_mobile/screens/ratings_screen.dart';
import 'package:hajusput_mobile/screens/travel_preferences_screen.dart';
import 'package:hajusput_mobile/utils/user_session.dart';
import 'package:hajusput_mobile/widgets/master_screen.dart';
import 'package:hajusput_mobile/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    _fetchDriverDetailsAndRating(UserSession.userId!);
  }

  Future<void> _fetchDriverDetailsAndRating(int userId) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final fetchedUser = await userProvider.getById(userId);

      setState(() {
        user = fetchedUser;
      });
    } catch (e) {
      print('Error fetching driver details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Profile',
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildUserInfoSection(),
              SizedBox(height: 20),
              _buildPreferencesSection(),
              SizedBox(height: 20),
              _buildCarSection(),
              SizedBox(height: 20),
              _buildOtherSections(),
            ],
          ),
        ),
      ),
      currentIndex: 4,
    );
  }

  Widget _buildUserInfoSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user?.firstName ?? 'First Name',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '@${user?.username ?? 'username'}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),

            // Edit Button
            ListTile(
              title: Text(
                'Edit Details',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditDetailsScreen(user: user!),
                  ),
                );
              },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preferences',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text(
                'My travel preferences',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyTravelPreferencesScreen()),
                );
              },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Car',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text(
                'Manage my car details',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CarScreen(userId: UserSession.userId!),
                  ),
                );
              },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtherSections() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Ratings'),
              leading: Icon(Icons.star),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RatingsScreen(userId: UserSession.userId!)),
                );
              },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              title: Text('Change Password'),
              leading: Icon(Icons.lock),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen()),
                );
              },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(Icons.logout, color: Colors.red),
              onTap: () async {
                await _handleLogout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _handleLogout(BuildContext context) async {
  UserSession.clear();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('You have been logged out.')),
  );

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()),
    (Route<dynamic> route) => false,
  );
}
