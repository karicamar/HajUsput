import 'package:flutter/material.dart';
import 'package:hajusput_mobile/providers/user_provider.dart';
import 'package:hajusput_mobile/utils/user_session.dart';
import 'package:provider/provider.dart';

class MyTravelPreferencesScreen extends StatefulWidget {
  @override
  _MyTravelPreferencesScreenState createState() =>
      _MyTravelPreferencesScreenState();
}

class _MyTravelPreferencesScreenState extends State<MyTravelPreferencesScreen> {
  Map<String, dynamic> preferences = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPreferences();
  }

  Future<void> _fetchPreferences() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final fetchedPreferences =
          await userProvider.getPreferences(UserSession.userId!);

      setState(() {
        preferences = fetchedPreferences;
      });
    } catch (e) {
      print('Error fetching preferences: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Travel Preferences'),
        backgroundColor: Colors.green.shade300,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : _buildPreferencesForm(),
    );
  }

  Widget _buildPreferencesForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPreferenceTile(
                'Chattiness',
                preferences['isChatty'] ?? 'Not set',
                [
                  'Not set',
                  'I\'m chatty!',
                  'Depending on the mood',
                  'I\'m the quiet type'
                ],
                'isChatty',
              ),
              SizedBox(height: 16),
              _buildPreferenceTile(
                'Music',
                preferences['allowsMusic'] ?? 'Not set',
                ['Not set', 'Prefer music!', 'Don\'t mind', 'Prefer silence'],
                'allowsMusic',
              ),
              SizedBox(height: 16),
              _buildPreferenceTile(
                'Smoking',
                preferences['allowsSmoking'] ?? 'Not set',
                [
                  'Not set',
                  'I\'m fine with smoking',
                  'Cigarette breaks!',
                  'No smoking!'
                ],
                'allowsSmoking',
              ),
              SizedBox(height: 16),
              _buildPreferenceTile(
                'Pets',
                preferences['allowsPets'] ?? 'Not set',
                [
                  'Not set',
                  'I love pets.',
                  'Depending on the animal',
                  'No pets allowed'
                ],
                'allowsPets',
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _savePreferences,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: Colors.green.shade300,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Save Preferences',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreferenceTile(String title, String currentValue,
      List<String> options, String preferenceKey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: options.contains(currentValue) ? currentValue : options[0],
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              preferences[preferenceKey] = newValue;
            });
          },
        ),
      ],
    );
  }

  Future<void> _savePreferences() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      await userProvider.updatePreferences(UserSession.userId!, preferences);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preferences saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save preferences: $e')),
      );
    }
  }
}
