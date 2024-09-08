import 'package:hajusput_mobile/models/car.dart';
import 'package:hajusput_mobile/providers/base_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CarProvider extends BaseProvider<Car> {
  CarProvider() : super("Car");

  @override
  Car fromJson(data) {
    // TODO: implement fromJson
    return Car.fromJson(data);
  }

  Future<Car> getByUserId(int userId) async {
    var url = "${baseUrl}Car/user/$userId";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Car.fromJson(data);
    } else {
      throw Exception('Failed to load car');
    }
  }
}
