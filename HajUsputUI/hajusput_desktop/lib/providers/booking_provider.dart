import 'dart:convert';

//import 'dart:convert';
import 'package:hajusput_desktop/models/booking.dart';
import 'package:hajusput_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class BookingProvider extends BaseProvider<Booking> {
  BookingProvider() : super("Booking");

  @override
  Booking fromJson(data) {
    // TODO: implement fromJson
    return Booking.fromJson(data);
  }

  Future<List<Booking>> getUserBookings(int userId) async {
    var url = "${baseUrl}Booking/user/$userId/bookings";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    final response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Booking.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load user bookings');
    }
  }

  Future<List<Booking>> getRideBookings(int rideId) async {
    var url = "${baseUrl}Booking/ride/$rideId/bookings";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    final response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Booking.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load user bookings');
    }
  }

  Future<void> confirmBooking(int bookingId) async {
    var uri = Uri.parse("${baseUrl}Booking/confirm-booking/$bookingId");
    var headers = createHeaders();

    final response = await http.post(
      uri,
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send message');
    }
  }

  Future<void> cancelBooking(int bookingId) async {
    var uri = Uri.parse("${baseUrl}Booking/cancel-booking/$bookingId");
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
