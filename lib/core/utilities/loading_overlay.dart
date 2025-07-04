import 'package:flutter/material.dart';

class LoadingOverlay {
  LoadingOverlay();

  @protected
  bool layerWaiting = false;

  @protected
  OverlayEntry? overlayEntryOpacity;

  @protected
  OverlayEntry? overlayEntryLoader;

  @protected
  OverlayEntry? overlayEntryLock;

  void showLoading(
    BuildContext context, {
    bool lockOnly = false,
  }) async {
    if (layerWaiting) return;
    layerWaiting = true;
    final NavigatorState? navigatorState = Navigator.maybeOf(context, rootNavigator: false);
    final OverlayState? overlayState = navigatorState?.overlay;

    if (overlayState != null) {
      if (lockOnly) {
        overlayEntryLock = lockBuilder();
        overlayState.insert(overlayEntryLock!);
      } else {
        overlayEntryOpacity = opacityBuilder();
        overlayEntryLoader = loadingBuilder();

        overlayState.insert(overlayEntryOpacity!);
        overlayState.insert(overlayEntryLoader!);
      }
    }
  }

  void hideLoading() {
    if (layerWaiting) {
      layerWaiting = false;
      overlayEntryLoader?.remove();
      overlayEntryLoader = null;
      overlayEntryOpacity?.remove();
      overlayEntryOpacity = null;
      overlayEntryLock?.remove();
      overlayEntryLock = null;
    }
  }

  @protected
  OverlayEntry opacityBuilder() => OverlayEntry(
        builder: (context) {
          return const Opacity(
            opacity: 0.5,
            child: ColoredBox(
              color: Colors.black,
            ),
          );
        },
      );

  @protected
  OverlayEntry loadingBuilder() => OverlayEntry(
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

  @protected
  OverlayEntry lockBuilder() => OverlayEntry(
        builder: (context) {
          return const AbsorbPointer(
            child: SizedBox.expand(),
          );
        },
      );
}
