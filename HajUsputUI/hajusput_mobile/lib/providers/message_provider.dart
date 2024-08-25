import 'dart:convert';
import 'package:hajusput_mobile/models/messages.dart';
import 'package:hajusput_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class MessageProvider extends BaseProvider<Messages> {
  MessageProvider() : super("MessageNotification");

  @override
  Messages fromJson(data) {
    return Messages.fromJson(data);
  }

  // Get messages for a specific user
  Future<List<Messages>> getMessagesForUser(int userId) async {
    var uri = Uri.parse("${baseUrl}MessageNotification/user/$userId");
    var headers = createHeaders();
    final response = await http.get(
      uri,
      headers: headers,
    );
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Messages.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  // Send a new message
  Future<void> sendMessage(Messages message) async {
    var uri = Uri.parse("${baseUrl}MessageNotification/send");
    var headers = createHeaders();

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(message.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send message');
    }
  }
}
