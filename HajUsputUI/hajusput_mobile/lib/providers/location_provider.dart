import 'dart:convert';

import 'package:hajusput_mobile/models/location.dart';
import 'package:hajusput_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class LocationProvider extends BaseProvider<Location> {
  LocationProvider() : super("Location");

  @override
  Location fromJson(data) {
    // TODO: implement fromJson
    return Location.fromJson(data);
  }

  Future<int?> fetchLocationId(String cityName) async {
    var uri = Uri.parse("${baseUrl}Location/checkId");
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(cityName),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to load location ID');
    }
  }
}
