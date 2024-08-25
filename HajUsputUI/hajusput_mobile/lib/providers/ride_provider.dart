import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:hajusput_mobile/models/ride.dart';
import 'package:hajusput_mobile/providers/base_provider.dart';

class RideProvider extends BaseProvider<Ride> {
  RideProvider() : super("Ride");

  @override
  Ride fromJson(data) {
    return Ride.fromJson(data);
  }

  Future<List<Ride>> getUserRides(int userId) async {
    var url = "${baseUrl}Ride/user/$userId";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    final response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Ride.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load user rides');
    }
  }

  Future<double> predictPrice(String? pickUpCity, String? dropOffCity,
      double? distance, double? durationMinutes, int? availableSeats) async {
    var url = "${baseUrl}Ride/predict";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode({
      'departureCity': pickUpCity,
      'destinationCity': dropOffCity,
      'distanceInKm': distance,
      'durationInMinutes': durationMinutes,
      'availableSeats': availableSeats,
    });

    var response = await http.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      final data = jsonDecode(response.body);
      return data['price'];
    } else {
      throw Exception('Failed to predict price');
    }
  }

  Future<void> reduceSeats(int rideId) async {
    var uri = Uri.parse("${baseUrl}Ride/reduce-seats/$rideId");
    var headers = createHeaders();

    final response = await http.post(
      uri,
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send message');
    }
  }
}
