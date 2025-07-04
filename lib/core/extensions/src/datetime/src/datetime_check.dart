/// DateTime check extension
extension DateTimeCheckExt on DateTime? {
  /// Check if the date is same as the given date
  bool isSameDate(DateTime? date) {
    if (this == null) return false;
    if (date == null) return false;

    return this!.year == date.year && this!.month == date.month && this!.day == date.day;
  }

  /// Check if the date is yesterday of the given date
  bool isYesterday(DateTime? date) {
    if (this == null) return false;
    if (date == null) return false;

    final DateTime yesterday = date.subtract(const Duration(days: 1));
    return isSameDate(yesterday);
  }

  /// Check if the date is tomorrow of the given date
  bool isTomorrow(DateTime? date) {
    if (this == null) return false;
    if (date == null) return false;

    final DateTime tomorrow = date.add(const Duration(days: 1));
    return isSameDate(tomorrow);
  }

  /// Check if the date is same week as the given date
  bool isSameWeek(DateTime? date) {
    if (this == null) return false;
    if (date == null) return false;
    if (isSameDate(date)) return true;

    final int weekDayDifference = this!.weekday - DateTime.monday;
    final DateTime startOfWeek = this!.subtract(Duration(days: weekDayDifference));
    final DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    if (date.isSameDate(startOfWeek)) return true;
    if (date.isSameDate(endOfWeek)) return true;

    return date.isAfter(startOfWeek) && date.isBefore(endOfWeek);
  }

  /// Check if the date is weekend
  bool get isWeekend {
    if (this == null) return false;
    return this!.weekday == DateTime.saturday || this!.weekday == DateTime.sunday;
  }

  /// Check if the date is weekday
  bool get isWeekday {
    if (this == null) return false;
    return !isWeekend;
  }
}
