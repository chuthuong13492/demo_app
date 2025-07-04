import 'package:flutter/widgets.dart';

import '../../iterable/iterable_extensions.dart';
import '../widget_extensions.dart';

/// Iterable widget format extension
extension IterableWidgetFormatExt on Iterable<Widget>? {
  /// Add spacing between each widget.
  List<Widget> spacing({
    required Widget Function(int index) spacing,
  }) {
    if (this == null) return [];
    if (this!.isEmpty) return [];

    final Iterable<Widget> widgets = this!.where((widget) => !widget.isEmpty);

    return widgets.toWidgetList(
      spacing: spacing,
      itemBuilder: (widget, _) => widget,
    );
  }
}
