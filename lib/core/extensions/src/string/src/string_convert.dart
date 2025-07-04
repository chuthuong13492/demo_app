// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart' show CanonicalizedMap;
import 'package:flutter/material.dart';

import '../../../extensions.dart';

final CanonicalizedMap<String, String, Color> _colorNames = CanonicalizedMap<String, String, Color>.from(
  {
    'transparent': Colors.transparent,
    'black': Colors.black,
    'black87': Colors.black87,
    'black54': Colors.black54,
    'black45': Colors.black45,
    'black38': Colors.black38,
    'black26': Colors.black26,
    'black12': Colors.black12,
    'white': Colors.white,
    'white70': Colors.white70,
    'white60': Colors.white60,
    'white54': Colors.white54,
    'white38': Colors.white38,
    'white30': Colors.white30,
    'white24': Colors.white24,
    'white12': Colors.white12,
    'white10': Colors.white10,
    'red': Colors.red,
    'redAccent': Colors.redAccent,
    'pink': Colors.pink,
    'pinkAccent': Colors.pinkAccent,
    'purple': Colors.purple,
    'purpleAccent': Colors.purpleAccent,
    'deepPurple': Colors.deepPurple,
    'deepPurpleAccent': Colors.deepPurpleAccent,
    'indigo': Colors.indigo,
    'indigoAccent': Colors.indigoAccent,
    'blue': Colors.blue,
    'blueAccent': Colors.blueAccent,
    'lightBlue': Colors.lightBlue,
    'lightBlueAccent': Colors.lightBlueAccent,
    'cyan': Colors.cyan,
    'cyanAccent': Colors.cyanAccent,
    'teal': Colors.teal,
    'tealAccent': Colors.tealAccent,
    'green': Colors.green,
    'greenAccent': Colors.greenAccent,
    'lightGreen': Colors.lightGreen,
    'lightGreenAccent': Colors.lightGreenAccent,
    'lime': Colors.lime,
    'limeAccent': Colors.limeAccent,
    'yellow': Colors.yellow,
    'yellowAccent': Colors.yellowAccent,
    'amber': Colors.amber,
    'amberAccent': Colors.amberAccent,
    'orange': Colors.orange,
    'orangeAccent': Colors.orangeAccent,
    'deepOrange': Colors.deepOrange,
    'deepOrangeAccent': Colors.deepOrangeAccent,
    'brown': Colors.brown,
    'grey': Colors.grey,
    'blueGrey': Colors.blueGrey,
  },
  (key) => key.removeAllWhiteSpace().removeDiacritics().toLowerCase(),
);

/// String convert extension
extension StringConvertExt on String? {
  /// Converts string to int or null.
  ///
  /// Example:
  /// ```dart
  /// '2021'.toIntOrNull(); // 2021
  /// '1f'.toIntOrNull(); // null
  /// // From binary (base 2) value.
  /// '1100'.toIntOrNull(radix: 2); // 12
  /// '00011111'.toIntOrNull(radix: 2); // 31
  /// '011111100101'.toIntOrNull(radix: 2); // 2021
  /// // From octal (base 8) value.
  /// '14'.toIntOrNull(radix: 8); // 12
  /// '37'.toIntOrNull(radix: 8); // 31
  /// '3745'.toIntOrNull(radix: 8); // 2021
  /// // From hexadecimal (base 16) value.
  /// 'c'.toIntOrNull(radix: 16); // 12
  /// '1f'.toIntOrNull(radix: 16); // 31
  /// '7e5'.toIntOrNull(radix: 16); // 2021
  /// // From base 35 value.
  /// 'y1'.toIntOrNull(radix: 35); // 1191 == 34 * 35 + 1
  /// 'z1'.toIntOrNull(radix: 35); // null
  /// // From base 36 value.
  /// 'y1'.toIntOrNull(radix: 36); // 1225 == 34 * 36 + 1
  /// 'z1'.toIntOrNull(radix: 36); // 1261 == 35 * 36 + 1
  /// ```
  int? toIntOrNull({int? radix}) {
    if (this == null || this!.isEmpty) return null;

    final int? value = int.tryParse(this!, radix: radix);

    if (value == null && radix == null) {
      if (isDouble) return toDoubleOrNull()?.toInt();
      if (isBoolean) return toBoolOrNull()?.toIntOrNull();
    }

    return value;
  }

  /// Converts string to int or default value.
  ///
  /// Example:
  /// ```dart
  /// '2021'.toInt(); // 2021
  /// '1f'.toInt(); // 0
  /// '1f'.toInt(defaultValue: 1); // 1
  /// // From binary (base 2) value.
  /// '1100'.toInt(radix: 2); // 12
  /// '00011111'.toInt(radix: 2); // 31
  /// '011111100101'.toInt(radix: 2); // 2021
  /// // From octal (base 8) value.
  /// '14'.toInt(radix: 8); // 12
  /// '37'.toInt(radix: 8); // 31
  /// '3745'.toInt(radix: 8); // 2021
  /// // From hexadecimal (base 16) value.
  /// 'c'.toInt(radix: 16); // 12
  /// '1f'.toInt(radix: 16); // 31
  /// '7e5'.toInt(radix: 16); // 2021
  /// // From base 35 value.
  /// 'y1'.toInt(radix: 35); // 1191 == 34 * 35 + 1
  /// 'z1'.toInt(radix: 35); // null
  /// // From base 36 value.
  /// 'y1'.toInt(radix: 36); // 1225 == 34 * 36 + 1
  /// 'z1'.toInt(radix: 36); // 1261 == 35 * 36 + 1
  /// ```
  int toInt({
    int defaultValue = 0,
    int? radix,
  }) {
    return toIntOrNull(radix: radix) ?? defaultValue;
  }

  /// Converts string to double or null.
  ///
  /// Example:
  /// ```dart
  /// '3.14'.toDoubleOrNull(); // 3.14
  /// '  3.14 \xA0'.toDoubleOrNull(); // 3.14
  /// '0.'.toDoubleOrNull(); // 0.0
  /// '.0'.toDoubleOrNull(); // 0.0
  /// '-1.e3'.toDoubleOrNull(); // -1000.0
  /// '1234E+7'.toDoubleOrNull(); // 12340000000.0
  /// '+.12e-9'.toDoubleOrNull(); // 1.2e-10
  /// '-NaN'.toDoubleOrNull(); // null
  /// '0xFF'.toDoubleOrNull(); // null
  /// double.infinity.toString().toDoubleOrNull(); // Infinity
  /// ```
  double? toDoubleOrNull() {
    if (this == null || this!.isEmpty) return null;

    final double? value = double.tryParse(this!);

    if (value != null && value.isNaN) return null;
    if (value == null && isBoolean) return toBoolOrNull()?.toDoubleOrNull();

    return value;
  }

  /// Converts string to double or default value.
  ///
  /// Example:
  /// ```dart
  /// '3.14'.toDouble(); // 3.14
  /// '  3.14 \xA0'.toDouble(); // 3.14
  /// '0.'.toDouble(); // 0.0
  /// '.0'.toDouble(); // 0.0
  /// '-1.e3'.toDouble(); // -1000.0
  /// '1234E+7'.toDouble(); // 12340000000.0
  /// '+.12e-9'.toDouble(); // 1.2e-10
  /// '-NaN'.toDouble(); // 0.0
  /// '0xFF'.toDouble(); // 0.0
  /// 'null'.toDouble(defaultValue: 1.0); // 1.0
  /// double.infinity.toString().toDouble(); // Infinity
  /// ```
  double toDouble({
    double defaultValue = 0.0,
  }) {
    return toDoubleOrNull() ?? defaultValue;
  }

  /// Converts string to bool or null.
  ///
  /// Example:
  /// ```dart
  /// 'true'.toBoolOrNull(); // true
  /// 'false'.toBoolOrNull(); // false
  /// '1'.toBoolOrNull(); // true
  /// '0'.toBoolOrNull(); // false
  /// '1.0'.toBoolOrNull(); // true
  /// '0.0'.toBoolOrNull(); // false
  /// 'null'.toBoolOrNull(); // null
  /// null.toBoolOrNull(); // null
  /// ```
  bool? toBoolOrNull() {
    if (this == null || this!.isEmpty) return null;

    final String value = this!.trim().replaceAll(' ', '').toLowerCase();

    if (value == 'true') return true;
    if (value == 'false') return false;
    if (value == '1') return true;
    if (value == '0') return false;
    if (value == '1.0') return true;
    if (value == '0.0') return false;

    return null;
  }

  /// Converts string to bool or default value.
  ///
  /// Example:
  /// ```dart
  /// 'true'.toBool(); // true
  /// 'false'.toBool(); // false
  /// '1'.toBool(); // true
  /// '0'.toBool(); // false
  /// '1.0'.toBool(); // true
  /// '0.0'.toBool(); // false
  /// 'null'.toBool(); // false
  /// null.toBool(defaultValue: true); // true
  /// ```
  bool toBool({
    bool defaultValue = false,
  }) {
    return toBoolOrNull() ?? defaultValue;
  }

  /// Converts string to datetime or null.
  ///
  /// Example:
  /// ```dart
  /// '2012-02-27'.toDateTimeOrNull(); // 2012-02-27 00:00:00.000
  /// '2012-02-27 13:27:00'.toDateTimeOrNull(); // 2012-02-27 13:27:00.000
  /// '2012-02-27 13:27:00.123456789z'.toDateTimeOrNull(); // 2012-02-27 13:27:00.123456Z
  /// '2012-02-27 13:27:00,123456789z'.toDateTimeOrNull(); // 2012-02-27 13:27:00.123456Z
  /// '20120227 13:27:00'.toDateTimeOrNull(); // 2012-02-27 13:27:00.000
  /// '20120227T132700'.toDateTimeOrNull(); // 2012-02-27 13:27:00.000
  /// '20120227'.toDateTimeOrNull(); // 2012-02-27 00:00:00.000
  /// '+20120227'.toDateTimeOrNull(); // 2012-02-27 00:00:00.000
  /// '2012-02-27T14Z'.toDateTimeOrNull(); // 2012-02-27 14:00:00.000Z
  /// '2012-02-27T14+00:00'.toDateTimeOrNull(); // 2012-02-27 14:00:00.000Z
  /// '-123450101 00:00:00 Z'.toDateTimeOrNull(); // -12345-01-01 00:00:00.000Z
  /// '2002-02-27T14:00:00-0500'.toDateTimeOrNull(); // 2002-02-27 19:00:00.000Z
  /// '19/07/2024'.toDateTimeOrNull(); // 2024-07-19 00:00:00.000
  /// '1/1/2024'.toDateTimeOrNull(); // 2024-01-01 00:00:00.000
  /// '2024/1/1'.toDateTimeOrNull(); // 2024-01-01 00:00:00.000
  /// '1-1-2024'.toDateTimeOrNull(); // 2024-01-01 00:00:00.000
  /// '2024-1-1'.toDateTimeOrNull(); // 2024-01-01 00:00:00.000
  /// '1.1.2024'.toDateTimeOrNull(); // 2024-01-01 00:00:00.000
  /// '2024.1.1'.toDateTimeOrNull(); // 2024-01-01 00:00:00.000
  /// '1/1/2024 1:1:1'.toDateTimeOrNull(); // 2024-01-01 01:01:01.000
  /// '2024/1/1 1:1:1'.toDateTimeOrNull(); // 2024-01-01 01:01:01.000
  /// '01/01/2024 01:01:01'.toDateTimeOrNull(); // 2024-01-01 01:01:01.000
  /// '2024/01/01 01:01:01'.toDateTimeOrNull(); // 2024-01-01 01:01:01.000
  /// '1-1-2024 1:1'.toDateTimeOrNull(); // 2024-01-01 01:01:00.000
  /// '2024-1-1 1:1'.toDateTimeOrNull(); // 2024-01-01 01:01:00.000
  /// '18:30:40'.toDateTimeOrNull(); // 0001-01-01 18:30:40.000
  /// '18:30'.toDateTimeOrNull(); // 0001-01-01 18:30:00.000
  /// ```
  DateTime? toDateTimeOrNull({
    bool isUtc = false,
  }) {
    String? str = this;
    if (str == null || str.isEmpty) return null;

    DateTime? dateTime = DateTime.tryParse(str);

    // if datetime null or year is more than 4 digits and isInt or isDouble
    // then convert to int and try to convert to DateTime
    if ((dateTime == null || dateTime.year.toString().length > 4) && (isInt || isDouble)) {
      return toIntOrNull()?.toDateTimeOrNull(isUtc: isUtc);
    }

    if (dateTime != null) return dateTime;

    // split date and time
    final int indexSplit = str.indexOf(RegExp('(T| )'));

    String? dateStr;
    String? timeStr;

    // if has date and time
    if (indexSplit >= 0) {
      dateStr = str.substring(0, indexSplit);
      timeStr = str.substring(indexSplit + 1, str.length);
    }
    // if only date or time
    else {
      if (str.isTime) {
        timeStr = str;
      } else {
        dateStr = str;
      }
    }

    // handle date format
    dateStr = dateStr?.replaceAll(RegExp(r'\s+'), '').replaceAll(RegExp('[^0-9+-]'), '-');

    final List<String> dateParts = dateStr?.split('-') ?? [];
    dateParts.removeWhere((e) => e.isEmpty);

    if (dateParts.length > 2) {
      int? year = dateParts.elementAtOrNull(0).toIntOrNull();
      final int? month = dateParts.elementAtOrNull(1).toIntOrNull();
      int? day = dateParts.elementAtOrNull(2).toIntOrNull();

      if (year != null && day != null && year < day) {
        final int temp = year;
        year = day;
        day = temp;
      }

      dateStr = <String>[
        year?.toString().padLeft(4, '0') ?? '0001',
        month?.toString().padLeft(2, '0') ?? '01',
        day?.toString().padLeft(2, '0') ?? '01',
      ].join('-');
    }

    // handle time format
    timeStr = timeStr?.replaceAll(RegExp(r'\s+'), '').replaceAll(RegExp('[^zZ0-9.,+-]'), ':');

    final List<String> timeParts = timeStr?.split(':') ?? [];

    if (timeParts.length > 1) {
      final String? hour = timeParts.elementAtOrNull(0);
      final String? minute = timeParts.elementAtOrNull(1);
      final String? second = timeParts.elementAtOrNull(2);

      timeStr = <String>[
        hour?.padLeft(2, '0') ?? '00',
        minute?.padLeft(2, '0') ?? '00',
        second?.padLeft(2, '0') ?? '00',
      ].join(':');
    }

    if (dateParts.isEmpty && timeParts.isEmpty) return null;

    str = <String>[
      dateStr ?? '0000-00-00',
      timeStr ?? '00:00:00',
    ].join(' ');

    // print('full: $this, date: $dateStr, time: $timeStr, replace: $str');

    dateTime = DateTime.tryParse(str);

    return dateTime;
  }

  /// Converts string to DateTime or default value.
  ///
  /// Example:
  /// ```dart
  /// '2012-02-27'.toDateTime(); // 2012-02-27 00:00:00.000
  /// '2012-02-27 13:27:00'.toDateTime(); // 2012-02-27 13:27:00.000
  /// '2012-02-27 13:27:00.123456789z'.toDateTime(); // 2012-02-27 13:27:00.123456Z
  /// '2012-02-27 13:27:00,123456789z'.toDateTime(); // 2012-02-27 13:27:00.123456Z
  /// '20120227 13:27:00'.toDateTime(); // 2012-02-27 13:27:00.000
  /// '20120227T132700'.toDateTime(); // 2012-02-27 13:27:00.000
  /// '20120227'.toDateTime(); // 2012-02-27 00:00:00.000
  /// '+20120227'.toDateTime(); // 2012-02-27 00:00:00.000
  /// '2012-02-27T14Z'.toDateTime(); // 2012-02-27 14:00:00.000
  /// '2012-02-27T14+00:00'.toDateTime(); // 2012-02-27 14:00:00.000Z
  /// '-123450101 00:00:00 Z'.toDateTime(); // -12345-01-01 00:00:00.000Z
  /// '2002-02-27T14:00:00-0500'.toDateTime(); // 2002-02-27 19:00:00.000Z
  /// '19/07/2024'.toDateTime(); // 2024-07-19 00:00:00.000
  /// '1/1/2024'.toDateTime(); // 2024-01-01 00:00:00.000
  /// '2024/1/1'.toDateTime(); // 2024-01-01 00:00:00.000
  /// '1-1-2024'.toDateTime(); // 2024-01-01 00:00:00.000
  /// '2024-1-1'.toDateTime(); // 2024-01-01 00:00:00.000
  /// '1.1.2024'.toDateTime(); // 2024-01-01 00:00:00.000
  /// '2024.1.1'.toDateTime(); // 2024-01-01 00:00:00.000
  /// '1/1/2024 1:1:1'.toDateTime(); // 2024-01-01 01:01:01.000
  /// '2024/1/1 1:1:1'.toDateTime(); // 2024-01-01 01:01:01.000
  /// '01/01/2024 01:01:01'.toDateTime(); // 2024-01-01 01:01:01.000
  /// '2024/01/01 01:01:01'.toDateTime(); // 2024-01-01 01:01:01.000
  /// '1-1-2024 1:1'.toDateTime(); // 2024-01-01 01:01:00.000
  /// '2024-1-1 1:1'.toDateTime(); // 2024-01-01 01:01:00.000
  /// '18:30:40'.toDateTime(); // 0001-01-01 18:30:40.000
  /// '18:30'.toDateTime(); // 0001-01-01 18:30:00.000
  /// ```
  DateTime toDateTime({
    required DateTime defaultValue,
    bool isUtc = false,
  }) {
    return toDateTimeOrNull(isUtc: isUtc) ?? defaultValue;
  }

  /// Converts string to valid url.
  String toUrl(
    String host, {
    String defaultValue = '',
  }) {
    String url;
    if (isEmptyOrNull) return defaultValue;

    if (isURL()) {
      url = this!;
    } else if (this!.startsWith('/')) {
      url = '$host$this';
    } else {
      url = '$host/$this';
    }
    url.replaceAll('//', '/');
    return url;
  }

  /// Convert string to Color or null.
  ///
  /// ```dart
  /// '#FFF'.toColorOrNull(); // Color(0xFFFFFFFF)
  /// '#123456'.toColorOrNull(); // Color(0xFF123456)
  /// 'rgb(255, 255, 255)'.toColorOrNull(); // Color.fromRGBO(255, 255, 255, 1)
  /// 'rgba(255, 255, 255, 0.5)'.toColorOrNull(); // Color.fromRGBO(255, 255, 255, 0.5)
  /// 'hsl(0, 100%, 50%)'.toColorOrNull(); // Color(0xFFFF0000)
  /// 'hsla(0, 100%, 50%, 0.5)'.toColorOrNull(); // Color(0x7fff0000)
  /// 'transparent'.toColorOrNull(); // Colors.transparent
  /// 'red'.toColorOrNull(); // Colors.red
  /// ```
  Color? toColorOrNull() {
    String? colorString = this;

    if (colorString == null || colorString.isEmpty) return null;

    if (colorString.startsWith('#')) {
      if (colorString.length == 4) {
        colorString =
            '#${colorString[1]}${colorString[1]}${colorString[2]}${colorString[2]}${colorString[3]}${colorString[3]}';
      }
      if (colorString.length == 7) {
        return Color(int.parse(colorString.substring(1), radix: 16) + 0xFF000000);
      } else if (colorString.length == 9) {
        final int colorValue = int.parse(colorString.substring(1), radix: 16);
        final int alpha = (colorValue & 0xFF);
        final int rgb = (colorValue >> 8);
        return Color((alpha << 24) + rgb);
      }
    } else if (colorString.startsWith('rgb')) {
      final match =
          RegExp(r'rgb(a?)\((\d{1,3}),\s*(\d{1,3}),\s*(\d{1,3})(,\s*(0|1|0?\.\d+))?\)').firstMatch(colorString);
      if (match != null) {
        final int r = int.parse(match.group(2)!);
        final int g = int.parse(match.group(3)!);
        final int b = int.parse(match.group(4)!);
        if (match.group(1) == 'a') {
          final double a = double.parse(match.group(6)!);
          return Color.fromRGBO(r, g, b, a);
        } else {
          return Color.fromRGBO(r, g, b, 1.0);
        }
      }
    } else if (colorString.startsWith('hsl')) {
      final match =
          RegExp(r'hsl(a?)\((\d{1,3}),\s*(\d{1,3})%,\s*(\d{1,3})%(,\s*(0|1|0?\.\d+))?\)').firstMatch(colorString);
      if (match != null) {
        final int h = int.parse(match.group(2)!);
        final double s = int.parse(match.group(3)!) / 100;
        final double l = int.parse(match.group(4)!) / 100;
        if (match.group(1) == 'a') {
          final double a = double.parse(match.group(6)!);
          return hslToColor(h, s, l, a);
        } else {
          return hslToColor(h, s, l, 1.0);
        }
      }
    } else if (_colorNames.containsKey(colorString)) {
      return _colorNames[colorString]!;
    }
    return null;
  }

  /// Convert string to Color or default value.
  ///
  /// ```dart
  /// '#FFF'.toColor(); // Color(0xFFFFFFFF)
  /// '#123456'.toColor(); // Color(0xFF123456)
  /// 'rgb(255, 255, 255)'.toColor(); // Color.fromRGBO(255, 255, 255, 1)
  /// 'rgba(255, 255, 255, 0.5)'.toColor(); // Color.fromRGBO(255, 255, 255, 0.5)
  /// 'hsl(0, 100%, 50%)'.toColor(); // Color(0xFFFF0000)
  /// 'hsla(0, 100%, 50%, 0.5)'.toColor(); // Color(0x7fff0000)
  /// 'transparent'.toColor(); // Colors.transparent
  /// 'red'.toColor(); // Colors.red
  ///
  /// ''.toColor(defaultValue: Colors.red); // Colors.red
  /// null.toColor(); // Colors.transparent
  /// ```
  ///
  /// * `defaultColor`: return this color if the hex code is invalid.
  Color toColor({
    Color defaultValue = Colors.transparent,
  }) {
    return toColorOrNull() ?? defaultValue;
  }
}
