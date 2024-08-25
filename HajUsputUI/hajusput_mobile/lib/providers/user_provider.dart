import 'dart:convert';
import 'package:hajusput_mobile/utils/user_session.dart';
import 'package:http/http.dart' as http;

import 'package:hajusput_mobile/models/user.dart';
import 'package:hajusput_mobile/providers/base_provider.dart';

class UserProvider extends BaseProvider<User> {
  UserProvider() : super("User");

  @override
  User fromJson(data) {
    // TODO: implement fromJson
    return User.fromJson(data);
  }

  Future<bool> checkUsername(String username) async {
    var uri = Uri.parse("${baseUrl}User/checkUsername");
    var response = await http.post(uri,
        body: jsonEncode(username),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['exists'];
    } else {
      throw Exception('Failed to check username');
    }
  }

  Future<bool> checkEmail(String email) async {
    var url = Uri.parse("${baseUrl}User/checkEmail");
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(email),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['exists'];
    } else {
      throw Exception('Failed to check email');
    }
  }

  Future<int> login(String username, String password) async {
    final url = Uri.parse("${baseUrl}User/login");
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final userId = data['userId'];

      UserSession.setUser(userId, username, password);

      return userId;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>> getPreferences(int userId) async {
    var uri = Uri.parse("${baseUrl}User/$userId/preferences");
    var response = await http.get(uri, headers: createHeaders());
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load preferences');
    }
  }

  Future<void> updatePreferences(
      int userId, Map<String, dynamic> preferences) async {
    var uri = Uri.parse("${baseUrl}User/$userId/preferences");
    var response = await http.put(
      uri,
      headers: createHeaders(),
      body: jsonEncode(preferences),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update preferences');
    }
  }

  Future<bool> changePassword(
      int userId, String oldPassword, String newPassword) async {
    var uri = Uri.parse("${baseUrl}User/change-password");
    final response = await http.post(
      uri,
      headers: createHeaders(),
      body: jsonEncode({
        'userId': userId,
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
