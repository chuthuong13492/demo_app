/// DateTime format extensions
extension DateTimeFormatExt on DateTime {
  /// Convert to DateTime (Date only)
  DateTime toDate() {
    return DateTime(year, month, day);
  }

  /// Converts to DateTime (Time only)
  ///
  /// [second] show second, default is false
  ///
  /// [millisecond] show millisecond, default is false
  ///
  /// [microsecond] show microsecond, default is false
  DateTime toTime({
    bool second = false,
    bool millisecond = false,
    bool microsecond = false,
  }) {
    return DateTime(
      0,
      0,
      0,
      hour,
      minute,
      second ? this.second : 0,
      millisecond ? this.millisecond : 0,
      microsecond ? this.microsecond : 0,
    );
  }

  /// Get first day of month
  DateTime get firstDayOfMonth {
    return DateTime(year, month, 1);
  }

  /// Get last day of month
  DateTime get lastDayOfMonth {
    return DateTime(year, month + 1, 0);
  }

  /// Get first day of week
  DateTime get firstDayOfWeek {
    return subtract(Duration(days: weekday - DateTime.monday));
  }

  /// Get last day of week
  DateTime get lastDayOfWeek {
    return add(Duration(days: DateTime.sunday - weekday));
  }
}

/// Nullable DateTime format extensions
extension NullableDateTimeFormatExt on DateTime? {
  /// Validate DateTime or return default value
  ///
  /// [defaultValue] is the default value to return if the DateTime is null.
  DateTime validate({
    required DateTime defaultValue,
  }) {
    return this ?? defaultValue;
  }

  /// Convert to DateTime (Date only) or null
  DateTime? toDateOrNull() {
    if (this == null) return null;

    return this!.toDate();
  }

  /// Convert to DateTime (Date only) or default value
  ///
  /// [defaultValue] is the default value to return if the DateTime is null.
  DateTime toDate({
    required DateTime defaultValue,
  }) {
    return toDateOrNull() ?? DateTime(defaultValue.year, defaultValue.month, defaultValue.day);
  }

  /// Converts to DateTime (Time only) or null.
  ///
  /// [second] show second, default is false
  ///
  /// [millisecond] show millisecond, default is false
  ///
  /// [microsecond] show microsecond, default is false
  DateTime? toTimeOrNull({
    bool second = false,
    bool millisecond = false,
    bool microsecond = false,
  }) {
    if (this == null) return null;
    return this!.toTime(
      second: second,
      millisecond: millisecond,
      microsecond: microsecond,
    );
  }

  /// Converts to DateTime (Time only) or default value.
  ///
  /// [defaultValue] is the default value to return if the DateTime is null.
  ///
  /// [second] show second, default is false
  ///
  /// [millisecond] show millisecond, default is false
  ///
  /// [microsecond] show microsecond, default is false
  DateTime toTime({
    required DateTime defaultValue,
    bool second = false,
    bool millisecond = false,
    bool microsecond = false,
  }) {
    return toTimeOrNull() ??
        DateTime(
          0,
          0,
          0,
          defaultValue.hour,
          defaultValue.minute,
          second ? defaultValue.second : 0,
          millisecond ? defaultValue.millisecond : 0,
          microsecond ? defaultValue.microsecond : 0,
        );
  }

  /// Get first day of month
  DateTime? get firstDayOfMonth {
    if (this == null) return null;

    return this!.firstDayOfMonth;
  }

  /// Get last day of month
  DateTime? get lastDayOfMonth {
    if (this == null) return null;

    return this!.lastDayOfMonth;
  }

  /// Get first day of week
  DateTime? get firstDayOfWeek {
    if (this == null) return null;

    return this!.firstDayOfWeek;
  }

  /// Get last day of week
  DateTime? get lastDayOfWeek {
    if (this == null) return null;

    return this!.lastDayOfWeek;
  }
}
