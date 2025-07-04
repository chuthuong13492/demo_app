import 'package:flutter/material.dart';

/// Color extension
extension ColorExt on Color {
  /// Get darker color by %
  ///
  /// [percent] is between 1 and 100.
  Color darken([int percent = 10]) {
    assert(1 <= percent && percent <= 100, 'percent must be between 1 and 100');
    final f = 1 - percent / 100;
    return Color.fromARGB(
      alpha,
      (red * f).round(),
      (green * f).round(),
      (blue * f).round(),
    );
  }

  /// Get lighter color by %
  ///
  /// [percent] is between 1 and 100.
  Color lighten([int percent = 10]) {
    assert(1 <= percent && percent <= 100, 'percent must be between 1 and 100');
    final p = percent / 100;
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }

  /// Get color as hex string
  ///
  /// [leadingHashSign] is whether to include leading hash sign.
  ///
  /// [includeAlpha] is whether to include alpha value.
  String toHex({
    bool leadingHashSign = true,
    bool includeAlpha = false,
  }) {
    return '${leadingHashSign ? '#' : ''}'
        '${includeAlpha ? alpha.toRadixString(16).padLeft(2, '0') : ''}'
        '${red.toRadixString(16).padLeft(2, '0')}'
        '${green.toRadixString(16).padLeft(2, '0')}'
        '${blue.toRadixString(16).padLeft(2, '0')}';
  }
}
