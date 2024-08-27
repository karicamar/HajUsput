import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

String googleMapsApi = dotenv.env['GOOGLE_API_KEY'] ?? '';

class Authorization {
  static String? username;
  static String? password;
}

class UserInfo {
  static int? userId;
}

String formatNumber(dynamic) {
  var f = NumberFormat('###,00');

  if (dynamic == null) {
    return "";
  }
  return f.format(dynamic);
}

String formatDate(DateTime? dateTime) {
  return DateFormat('MMMM d').format(dateTime!);
}

String formatTime(DateTime? dateTime) {
  return DateFormat('HH:mm').format(dateTime!);
}

String formatDuration(double minutes) {
  final hours = minutes ~/ 60;
  final remainingMinutes = (minutes % 60).toInt();
  return '$hours hours $remainingMinutes minutes';
}

String formatMessageDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final messageDate = DateTime(date.year, date.month, date.day);

  if (messageDate == today) {
    // If the message is from today, show only the time
    return DateFormat('HH:mm').format(date);
  } else if (messageDate == today.subtract(Duration(days: 1))) {
    // If the message is from yesterday, show 'Yesterday' and the time
    return 'Yesterday, ${DateFormat('HH:mm').format(date)}';
  } else if (now.difference(date).inDays < 7) {
    // If the message is within the last week, show the day of the week and the time
    return '${DateFormat('EEEE').format(date)}, ${DateFormat('HH:mm').format(date)}';
  } else {
    // Otherwise, show the date and time
    return DateFormat('MMM dd, yyyy, HH:mm').format(date);
  }
}
