import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Colors
const kBackgroundColor = Color(0xFFD2FFF4);
const kPrimaryColor = Color(0xFF2D5D70);
const kSecondaryColor = Color(0xFF265DAB);

class Authorization {
  static String? username;
  static String? password;
}

String formatNumber(dynamic) {
  var f = NumberFormat('###,00');

  if (dynamic == null) {
    return "";
  }
  return f.format(dynamic);
}
