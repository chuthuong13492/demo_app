/// Number check extension
extension NumberCheckExt on num? {
  /// Check if the number is null or zero.
  bool get isZeroOrNull {
    if (this == null) return true;
    if (this! == 0) return true;

    return false;
  }

  /// Check if the number is not null and not zero.
  bool get isNotZeroAndNull => !isZeroOrNull;

  /// Check if the number is even.
  bool get isEven {
    if (this == null) return false;

    return this! % 2 == 0;
  }

  /// Check if the number is odd.
  bool get isOdd {
    if (this == null) return false;

    return this! % 2 != 0;
  }
}

extension TimeExt on num {
  String videoTimeFormat() {
    DateTime initDate = DateTime(0, 0, 0);
    initDate = initDate.add(Duration(seconds: toInt()));
    final String seconds = '${initDate.second}'.padLeft(2, '0');
    final String minutes = '${initDate.minute}'.padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
