//import 'dart:convert';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:hajusput_mobile/models/review.dart';
import 'package:hajusput_mobile/providers/base_provider.dart';

class ReviewProvider extends BaseProvider<Review> {
  ReviewProvider() : super("ReviewRating");

  @override
  Review fromJson(data) {
    // TODO: implement fromJson
    return Review.fromJson(data);
  }

  Future<double?> getDriverRating(int? driverId) async {
    var uri = Uri.parse("${baseUrl}ReviewRating/driver/$driverId/rating");
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},

      //body: jsonEncode(driverId),
    );

    if (response.statusCode == 200) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return double.tryParse(response.body);
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Map<String, List<Review>>> getRatingsByUser(int? userId) async {
    var uri = Uri.parse("${baseUrl}ReviewRating/user/$userId");
    final response = await http.get(
      uri,
      headers: createHeaders(),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, List<Review>> ratings = {
        "GivenReviews": (body["GivenReviews"] as List<dynamic>)
            .map((item) => Review.fromJson(item))
            .toList(),
        "ReceivedReviews": (body["ReceivedReviews"] as List<dynamic>)
            .map((item) => Review.fromJson(item))
            .toList(),
      };
      return ratings;
    } else if (response.statusCode == 404) {
      return {
        "GivenReviews": [],
        "ReceivedReviews": [],
      };
    } else {
      throw Exception('Failed to load ratings');
    }
  }

  Future<int> getTotalRatingsCount(int userId) async {
    final ratings = await getRatingsByUser(userId);
    return ratings["ReceivedReviews"]!.length;
  }
}
