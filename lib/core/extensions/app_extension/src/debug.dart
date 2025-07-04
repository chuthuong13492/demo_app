part of '../app_extension.dart';

final Talker debugTalker = Talker(
  logger: TalkerLogger(
    settings: TalkerLoggerSettings(
      lineSymbol: '',
      maxLineWidth: 0,
    ),
    formatter: const ColoredLoggerFormatter(),
    output: (message) {
      if (kDebugMode) {
        log(message, name: 'Debug');
      }
    },
  ),
);

// ignore: library_private_types_in_public_api
extension LogExt on _AppExt {
  void logError({
    required String title,
    required Object? error,
    StackTrace? stackTrace,
    bool takeScreenshot = false,
  }) {
    if (error is DioException) return;

    if (error is String?) error = Exception(error);

    return debugTalker.error(
      '[$title]',
      error,
      stackTrace,
    );
  }

  void logDebug({
    required String title,
    required String message,
    Map<String, Object?>? data,
  }) {
    String? debugMessage = '[$title] $message';

    if (data != null) {
      debugMessage += '\ndata: $data';
    }

    return debugTalker.debug(debugMessage);
  }
}
