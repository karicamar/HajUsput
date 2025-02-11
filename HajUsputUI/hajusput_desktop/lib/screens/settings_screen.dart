import 'package:flutter/material.dart';
import 'package:hajusput_desktop/screens/manage_carmakes_screen.dart';
import 'package:hajusput_desktop/screens/manage_genders_screen.dart';
import 'package:hajusput_desktop/screens/manage_locations_screen.dart';
import 'package:hajusput_desktop/screens/manage_roles_screen.dart';
import '../widgets/master_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Settings',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSettingsCategory(
              title: 'Role Management',
              icon: Icons.people,
              onTap: () => _navigateTo(context, ManageRolesScreen()),
            ),
            _buildSettingsCategory(
              title: 'Car Management',
              icon: Icons.directions_car,
              onTap: () => _navigateTo(context, ManageCarMakesScreen()),
            ),
            _buildSettingsCategory(
              title: 'Gender Management',
              icon: Icons.person,
              onTap: () => _navigateTo(context, ManageGendersScreen()),
            ),
            _buildSettingsCategory(
              title: 'Location Management',
              icon: Icons.card_travel_rounded,
              onTap: () => _navigateTo(context, ManageLocationsScreen()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCategory({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
