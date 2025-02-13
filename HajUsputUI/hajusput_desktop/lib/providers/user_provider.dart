import 'dart:convert';
import 'package:hajusput_desktop/utils/user_session.dart';
import 'package:http/http.dart' as http;

import 'package:hajusput_desktop/models/user.dart';
import 'package:hajusput_desktop/providers/base_provider.dart';

class UserProvider extends BaseProvider<User> {
  UserProvider() : super("User");

  @override
  User fromJson(data) {
    // TODO: implement fromJson
    return User.fromJson(data);
  }

  Future<int> getTotalUsers() async {
    var url = "${baseUrl}User/total-users";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    final response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      return int.parse(response.body);
    } else {
      throw Exception('Failed to load active users');
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
      final roleName = data['userRoles'][0]['role']['roleName'];

      if (roleName != 'Admin') {
        throw Exception("Only admins are allowed to log in.");
      }

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

  Future<void> blockUser(int id) async {
    var uri = Uri.parse("${baseUrl}User/Block/$id");
    var headers = createHeaders();

    final response = await http.put(
      uri,
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send message');
    }
  }
}
