import 'dart:convert';
import 'package:hajusput_desktop/models/ride.dart';
import 'package:hajusput_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class RideProvider extends BaseProvider<Ride> {
  RideProvider() : super("Ride");

  @override
  Ride fromJson(data) {
    return Ride.fromJson(data);
  }

// Fetch total number of rides
  Future<int> getTotalRides() async {
    var url = "${baseUrl}Ride/total-rides";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    final response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      return int.parse(response.body);
    } else {
      throw Exception('Failed to load total rides');
    }
  }

  Future<String> getTotalDistanceTraveled() async {
    var url = "${baseUrl}Ride/total-distance";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    final response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      double distance = double.parse(response.body);
      return distance.toStringAsFixed(2); // Format to 2 decimal places

      //return double.parse(response.body);
    } else {
      throw Exception('Failed to load total distance');
    }
  }

  Future<String> getAverageDistanceTraveled() async {
    var url = "${baseUrl}Ride/average-distance";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    final response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      double distance = double.parse(response.body);
      return distance.toStringAsFixed(2); // Format to 2 decimal places

      //return double.parse(response.body);
    } else {
      throw Exception('Failed to load total distance');
    }
  }

  // Fetch number of active rides
  Future<int> getScheduledRides() async {
    var url = "${baseUrl}Ride/scheduled-rides";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    final response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      return int.parse(response.body);
    } else {
      throw Exception('Failed to load active rides');
    }
  }

  Future<int> getCancelledRides() async {
    var url = "${baseUrl}Ride/cancelled-rides";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    final response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      return int.parse(response.body);
    } else {
      throw Exception('Failed to load active rides');
    }
  }

  Future<int> getArchivedRides() async {
    var url = "${baseUrl}Ride/archived-rides";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    final response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      return int.parse(response.body);
    } else {
      throw Exception('Failed to load active rides');
    }
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

  // Aggregated analysis data
  Future<Map<String, int>> getRideAnalysis() async {
    try {
      final scheduled = await getScheduledRides();
      final cancelled = await getCancelledRides();
      final archived = await getArchivedRides();

      return {
        "Scheduled": scheduled,
        "Cancelled": cancelled,
        "Archived": archived,
      };
    } catch (e) {
      throw Exception('Failed to load ride analysis: $e');
    }
  }
}
