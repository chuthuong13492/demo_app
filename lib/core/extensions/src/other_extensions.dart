import 'dart:ui';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart' show DeepCollectionEquality;

/// Check if two objects are equal.
///
/// If [customEqual] is provided, it will be used to check equality.
bool areEqual(
  Object? a,
  Object? b, {
  bool? Function(Object? a, Object? b)? customEqual,
}) {
  final bool? equal = customEqual?.call(a, b);

  if (equal != null) {
    return equal;
  }

  return const DeepCollectionEquality().equals(a, b);
}

/// Get color from HSL.
Color hslToColor(int h, double s, double l, double a) {
  final c = (1 - (2 * l - 1).abs()) * s;
  final x = c * (1 - ((h / 60) % 2 - 1).abs());
  final m = l - c / 2;
  double r = 0;
  double g = 0;
  double b = 0;
  if (h < 60) {
    r = c;
    g = x;
  } else if (h < 120) {
    r = x;
    g = c;
  } else if (h < 180) {
    g = c;
    b = x;
  } else if (h < 240) {
    g = x;
    b = c;
  } else if (h < 300) {
    r = x;
    b = c;
  } else if (h < 360) {
    r = c;
    b = x;
  }
  r = ((r + m) * 255).roundToDouble();
  g = ((g + m) * 255).roundToDouble();
  b = ((b + m) * 255).roundToDouble();
  return Color.fromRGBO(r.toInt(), g.toInt(), b.toInt(), a);
}

/// Check if the type is the same or nullable type.
bool isTypeOrNullableType<FixedType, UnknownType>() {
  if (FixedType == UnknownType) return true;
  return FixedType.toString().replaceAll('?', '') == UnknownType.toString().replaceAll('?', '');
}
