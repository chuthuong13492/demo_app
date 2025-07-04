import 'dart:math';

/// Int format extension.
extension IntFormatExt on int? {
  /// Converts data to int or default value.
  int validate({
    int defaultValue = 0,
  }) {
    return this ?? defaultValue;
  }
}

/// Double format extension.
extension DoubleFormatExt on double? {
  /// Converts data to double or default value.
  double validate({
    double defaultValue = 0.0,
  }) {
    return this ?? defaultValue;
  }
}

/// Number format extension.
extension NumberFormatExt on num? {
  /// degree to radian.
  double? get degreeToRadian {
    if (this == null) return null;

    return this! * pi / 180;
  }

  /// radian to degree.
  double? get radianToDegree {
    if (this == null) return null;

    return this! * 180 / pi;
  }
}
