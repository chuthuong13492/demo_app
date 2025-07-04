import 'package:flutter/widgets.dart';

/// Widget check extension
extension WidgetCheckExt on Widget? {
  /// Check if the widget is empty
  bool get isEmpty {
    if (this == null) return true;
    final Widget widget = this!;

    if (widget is Text) {
      if (widget.data == null) return true;
      if (widget.data!.isEmpty) return true;
      return false;
    }

    if (widget is SizedBox) {
      if (widget.height != null && widget.height != 0) return false;
      if (widget.width != null && widget.width != 0) return false;
      if (widget.height == 0 && widget.width == 0) return true;
      if (widget.height == null && widget.width == null) return widget.child.isEmpty;
      if (widget.height == null && widget.width == 0) return widget.child.isEmpty;
      if (widget.height == 0 && widget.width == null) return widget.child.isEmpty;
      return false;
    }

    if (widget is Container) {
      // check padding
      final EdgeInsetsGeometry? padding = widget.padding;
      if (padding != null) {
        if (padding.horizontal == 0 && padding.vertical == 0) return widget.child.isEmpty;
        return false;
      }

      // check margin
      final EdgeInsetsGeometry? margin = widget.margin;
      if (margin != null) {
        if (margin.horizontal == 0 && margin.vertical == 0) return widget.child.isEmpty;
        return false;
      }

      // check constraints
      // put this at the end
      final BoxConstraints? constraints = widget.constraints;
      if (constraints == null) return widget.child.isEmpty;
      if (constraints.minHeight == 0 &&
          constraints.maxHeight == 0 &&
          constraints.minWidth == 0 &&
          constraints.maxWidth == 0) {
        return true;
      }
      if (constraints.minHeight == 0 &&
          constraints.maxHeight == 0 &&
          constraints.minWidth == 0 &&
          constraints.maxWidth <= double.infinity) {
        return widget.child.isEmpty;
      }
      if (constraints.minWidth == 0 &&
          constraints.maxWidth == 0 &&
          constraints.minHeight == 0 &&
          constraints.maxHeight <= double.infinity) {
        return widget.child.isEmpty;
      }

      return false;
    }

    if (widget is LimitedBox) {
      if (widget.maxWidth == 0 && widget.maxHeight == 0) return true;
      return false;
    }

    if (widget is Visibility) {
      if (!widget.visible) return true;
      return widget.child.isEmpty;
    }

    if (widget is Padding) {
      if (widget.padding.horizontal == 0 && widget.padding.vertical == 0) return widget.child.isEmpty;
      return false;
    }

    if (widget is SliverPadding) {
      if (widget.padding.horizontal == 0 && widget.padding.vertical == 0) return widget.child.isEmpty;
      return false;
    }

    // put this at the end
    if (widget is SingleChildRenderObjectWidget) {
      return widget.child.isEmpty;
    }

    // put this at the end
    if (widget is MultiChildRenderObjectWidget) {
      if (widget.children.isEmpty) return true;
      return widget.children.every((child) => child.isEmpty);
    }

    return false;
  }
}
