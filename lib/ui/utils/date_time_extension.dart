import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// used intl package
  String get toFormattedDate {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(this);
  }

  /// with out use package
  // String get toFormattedDate {
  //   return "$day / $month / $year";
  // }

  String get dayName {
    List<String> days = [ "mon", "the", "wed", "thu", "fri","sat", "sun"];
    return days[weekday - 1];
  }
}
