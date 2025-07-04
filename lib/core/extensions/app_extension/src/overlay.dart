part of '../app_extension.dart';

Completer<void>? _overlayCompleter;

final LoadingOverlay _loadingOverlay = LoadingOverlay();

extension OverlayExt on _AppExt {
  Future<void> waitCurrentOverlayClose() {
    return _overlayCompleter?.future ?? Future.sync(() => null);
  }

  Future<T?> showDialog<T>({
    required material.Widget child,
    bool waitOverlayComplete = false,
    bool barrierDismissible = true,
  }) async {
    if (waitOverlayComplete && _overlayCompleter != null && !_overlayCompleter!.isCompleted) {
      await _overlayCompleter?.future;
    }

    _overlayCompleter ??= Completer();

    if (!context.mounted) return null;
    final data = await material.showDialog<T>(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return child;
      },
    );
    if (!(_overlayCompleter?.isCompleted ?? true)) {
      _overlayCompleter?.complete(null);
      _overlayCompleter = null;
    }

    return data;
  }

  Future<T?> showBottomSheet<T>({
    required Widget child,
    bool waitOverlayComplete = false,
    bool isDismissible = true,
    bool isScrollControlled = false,
  }) async {
    if (waitOverlayComplete && _overlayCompleter != null && !_overlayCompleter!.isCompleted) {
      await _overlayCompleter?.future;
    }

    _overlayCompleter ??= Completer();

    if (!context.mounted) return null;
    final data = await showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      useSafeArea: true,
      builder: (_) => child,
    );

    if (!(_overlayCompleter?.isCompleted ?? true)) {
      _overlayCompleter?.complete(null);
      _overlayCompleter = null;
    }

    return data;
  }

  /// Close bottom sheet (number of bottom sheets to close)
  ///
  /// If null, close all
  void closeBottomSheet([int? number = 1]) {
    Navigator.of(context).popUntil(
      (route) {
        final String type = route.runtimeType.toString().toUpperCase();
        if (number != null && number! <= 0) return true;

        if (route is PopupRoute) {
          if (type.contains(RegExp('BOTTOMSHEET'))) {
            if (number != null) {
              number = number! - 1;
            }

            return false;
          }
        }
        return true;
      },
    );
  }

  /// Close dialog (number of dialogs to close)
  ///
  /// If null, close all
  void closeDialog([int? number = 1]) {
    Navigator.of(context).popUntil(
      (route) {
        final String type = route.runtimeType.toString().toUpperCase();
        if (number != null && number! <= 0) return true;

        if (route is PopupRoute) {
          if (type.contains(RegExp('DIALOG'))) {
            if (number != null) {
              number = number! - 1;
            }

            return false;
          }
        }
        return true;
      },
    );
  }

  void showLoading({bool lockOnly = false}) => _loadingOverlay.showLoading(context, lockOnly: lockOnly);

  void hideLoading() => _loadingOverlay.hideLoading();
}
