import 'dart:math';

import 'package:flutter/material.dart';

/// Nullable list format extension
extension NullableListFormatExt<T> on List<T>? {
  /// Validate the list and return a default value if the list is null or empty.
  List<T> validate({
    List<T> defaultValue = const [],
  }) {
    if (this == null) return defaultValue;
    if (this!.isEmpty) return defaultValue;

    return this!;
  }
}

/// List format extension
extension ListFormatExt<T> on List<T> {
  /// Sort the list by the given [compare].
  ///
  /// Same list with sort. Not create a new list.
  List<T> sorted([int Function(T a, T b)? compare]) {
    sort(compare);
    return this;
  }
}

/// Nullable set format extension
extension NullableSetFormatExt<T> on Set<T>? {
  /// Validate the set and return a default value if the set is null or empty.
  Set<T> validate({
    Set<T> defaultValue = const {},
  }) {
    if (this == null) return defaultValue;
    if (this!.isEmpty) return defaultValue;

    return this!;
  }
}

/// Iterable format extension
extension IterableFormatExt<T> on Iterable<T>? {
  /// Format the list to a list of widgets.
  List<Widget> toWidgetList({
    required Widget Function(T item, int index) itemBuilder,
    Widget Function(int index)? spacing,
  }) {
    if (this == null) return [];
    if (this!.isEmpty) return [];

    return List.generate(
      max(this!.length * 2 - 1, 0),
      (index) {
        final int i = index ~/ 2;

        if (index.isOdd) return spacing?.call(i) ?? const SizedBox.shrink();

        final T item = this!.elementAt(i);
        return itemBuilder(item, i);
      },
    );
  }
}
