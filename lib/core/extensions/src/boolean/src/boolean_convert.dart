/// Boolean convert extension
extension BooleanConvertExt on bool? {
  /// Convert boolean to integer
  ///
  /// Examples:
  /// ```dart
  /// true.toIntOrNull();  // 1
  /// false.toIntOrNull(); // 0
  /// null.toIntOrNull(): // null
  /// ```
  int? toIntOrNull() {
    if (this == null) return null;
    return this! ? 1 : 0;
  }

  /// Convert boolean to integer
  ///
  /// Examples:
  /// ```dart
  /// true.toInt();  // 1
  /// false.toInt(); // 0
  /// null.toInt(): // 0
  /// ```
  int toInt({
    int defaultValue = 0,
  }) {
    return toIntOrNull() ?? defaultValue;
  }

  /// Convert boolean to double
  ///
  /// Examples:
  /// ```dart
  /// true.toDoubleOrNull();  // 1.0
  /// false.toDoubleOrNull(); // 0.0
  /// null.toDoubleOrNull(): // null
  /// ```
  double? toDoubleOrNull() {
    if (this == null) return null;
    return this! ? 1.0 : 0.0;
  }

  /// Convert boolean to double
  ///
  /// Examples:
  /// ```dart
  /// true.toDouble();  // 1.0
  /// false.toDouble(); // 0.0
  /// null.toDouble(): // 0.0
  /// ```
  double toDouble({
    double defaultValue = 0.0,
  }) {
    return toDoubleOrNull() ?? defaultValue;
  }
}
