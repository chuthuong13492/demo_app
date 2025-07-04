import 'dart:math';

import 'package:intl/intl.dart';

/// Number convert extension
extension NumberConvertExt on num? {
  /// Converts file size to human readable format.
  String toFileSize({
    bool base1024 = true,
    int beginUnit = 0,
    String format = '#,##0.#',
  }) {
    if (this == null) return '0';
    if (this! <= 0) return '0';

    final base = base1024 ? 1024 : 1000;

    final units = ['B', 'kB', 'MB', 'GB', 'TB'];
    final int digitGroups = (log(this!) / log(base)).round();

    return '${NumberFormat(format).format(this! / pow(base, digitGroups))} ${units[digitGroups + beginUnit]}';
  }

  /// Converts num to date time or null.
  DateTime? toDateTimeOrNull({bool isUtc = false}) {
    if (this == null) return null;

    const int minEpochValue = 0; // Epoch start
    final int maxEpochValueInSeconds =
        DateTime.now()
            .add(const Duration(days: 365 * 50))
            .millisecondsSinceEpoch ~/
        1000;
    final int maxEpochValueInMilliseconds = maxEpochValueInSeconds * 1000;
    final int maxEpochValueInMicroseconds = maxEpochValueInMilliseconds * 1000;

    if (this! >= minEpochValue) {
      if (this! <= maxEpochValueInSeconds) {
        // Likely in seconds
        return DateTime.fromMillisecondsSinceEpoch(
          this!.toInt() * 1000,
          isUtc: isUtc,
        );
      } else if (this! <= maxEpochValueInMilliseconds) {
        // Likely in milliseconds
        return DateTime.fromMillisecondsSinceEpoch(this!.toInt(), isUtc: isUtc);
      } else if (this! <= maxEpochValueInMicroseconds) {
        // Likely in microseconds
        return DateTime.fromMicrosecondsSinceEpoch(this!.toInt(), isUtc: isUtc);
      }
    }

    return null; // Not a valid timestamp or out of expected range
  }

  /// Converts num to date time or default value.
  DateTime toDateTime({required DateTime defaultValue, bool isUtc = false}) {
    return toDateTimeOrNull(isUtc: isUtc) ?? defaultValue;
  }
}
