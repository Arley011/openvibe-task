import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// Returns string in format HH:mm (e.g. 13:00)
  String get formattedTime24H {
    return DateFormat().add_Hm().format(this);
  }

  /// Returns string in format dd MMM yy (e.g. 23 Jan 21)
  String get formattedDate {
    return DateFormat('dd MMM yy').format(this);
  }
}
