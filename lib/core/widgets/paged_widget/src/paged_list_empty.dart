import 'package:flutter/material.dart';

/// A widget that displays a list with an empty space
/// that can be used to scroll the list for refresh when the list is empty.
class PagedListEmpty extends StatelessWidget {
  /// Creates a widget that displays a list with an empty space
  /// that can be used to scroll the list for refresh when the list is empty.
  const PagedListEmpty({
    super.key,
    required this.child,
    this.scrollController,
  });

  /// The child widget to display.
  final Widget child;

  /// The scroll controller to use.
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            child,
            SingleChildScrollView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: SizedBox.fromSize(
                size: constraints.biggest,
              ),
            ),
          ],
        );
      },
    );
  }
}
