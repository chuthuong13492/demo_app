import 'package:intl/intl.dart';

/// DateTime convert extension
extension DateTimeConvertExt on DateTime? {
  /// Convert DateTime to formatted string
  ///
  /// [format] is the format of the date.
  String showDate({String format = 'dd/MM/yyyy'}) {
    if (this == null) {
      return '';
    }
    return DateFormat(format).format(this!);
  }

  /// Get days in month
  int get daysInMonth {
    if (this == null) return 0;

    final DateTime beginningNextMonth =
        (this!.month < 12) ? DateTime(this!.year, this!.month + 1, 1) : DateTime(this!.year + 1, 1, 1);

    return beginningNextMonth.subtract(const Duration(days: 1)).day;
  }
}
