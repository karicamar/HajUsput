import 'package:hajusput_mobile/models/payment.dart';
import 'package:hajusput_mobile/providers/base_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentProvider extends BaseProvider<Payment> {
  PaymentProvider() : super("Payment");

  @override
  Payment fromJson(data) {
    // TODO: implement fromJson
    return Payment.fromJson(data);
  }

  Future<Map<String, dynamic>> createPaymentIntent(double amount) async {
    var uri = Uri.parse("${baseUrl}Payment/create-payment-intent");
    var headers = createHeaders();
    var body = jsonEncode({"amount": amount});

    final response = await http.post(uri, headers: headers, body: body);
    if (response.statusCode != 200) {
      throw Exception('Failed to create PaymentIntent');
    }

    return jsonDecode(response.body);
  }

  Future<void> confirmPayment(int paymentId) async {
    var uri = Uri.parse("${baseUrl}Payment/confirm-payment/$paymentId");
    var headers = createHeaders();

    final response = await http.post(uri, headers: headers);
    if (response.statusCode != 200) {
      throw Exception('Failed to confirm payment');
    }
  }

  Future<void> failPayment(int paymentId) async {
    var uri = Uri.parse("${baseUrl}Payment/fail-payment/$paymentId");
    var headers = createHeaders();

    final response = await http.post(uri, headers: headers);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode != 200) {
      throw Exception('Failed to fail payment');
    }
  }
}
