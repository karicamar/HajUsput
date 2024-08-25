import 'dart:convert';
import 'dart:typed_data';
import 'package:hajusput_desktop/models/payment.dart';
import 'package:hajusput_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class PaymentProvider extends BaseProvider<Payment> {
  PaymentProvider() : super("Payment");

  @override
  Payment fromJson(data) {
    // TODO: implement fromJson
    return Payment.fromJson(data);
  }

  Future<double> getTotalRevenue({Map<String, dynamic>? filter}) async {
    // Construct the base URL for the total revenue endpoint
    var url = "${baseUrl}Payment/total-revenue";

    // If a filter is provided, generate a query string and append it to the URL
    if (filter != null) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }

    // Parse the final URL with the query string
    var uri = Uri.parse(url);
    var headers = createHeaders();

    // Send the GET request to fetch the total revenue
    final response = await http.get(uri, headers: headers);

    // Check if the response is valid and parse the body as a double
    if (isValidResponse(response)) {
      return double.parse(response.body);
    } else {
      // Throw an exception if the request fails
      throw Exception('Failed to load the revenue');
    }
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

  // Future<List<Payment>> getFinancialReport(
  //     DateTime startDate, DateTime endDate, String paymentStatus) async {
  //   var uri = Uri.parse("${baseUrl}Payment/get-financial-report");
  //   var headers = createHeaders();
  //   var body = jsonEncode({
  //     'startDate': startDate.toIso8601String(),
  //     'endDate': endDate.toIso8601String(),
  //     'paymentStatus': paymentStatus,
  //   });

  //   final response = await http.post(uri, headers: headers, body: body);

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body) as List;
  //     return data.map((json) => Payment.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load financial report');
  //   }
  // }

  Future<Uint8List> generateFinancialReportPdf(DateTime startDate,
      DateTime endDate, String paymentStatus, String paymentMethod) async {
    var uri = Uri.parse("${baseUrl}Payment/generate-financial-report-pdf");
    var headers = createHeaders();
    var body = jsonEncode({
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'paymentStatus': paymentStatus,
      'paymentMethod': paymentMethod,
    });

    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to generate PDF report');
    }
  }
}
