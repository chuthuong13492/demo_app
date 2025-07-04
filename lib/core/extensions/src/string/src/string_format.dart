import 'package:diacritic/diacritic.dart' as diacritic;

import 'string_check.dart';

/// Nullable string format extension
extension NullableStringFormatExt on String? {
  /// Validate the string and return the default value if it is null or empty.
  String validate({String defaultValue = ''}) {
    if (this == null) return defaultValue;
    if (this!.isEmpty) return defaultValue;

    return this!;
  }
}

/// String format extension
extension StringFormatExt on String {
  /// Remove all white spaces at the beginning and end of the string.
  /// Remove all duplicate white spaces in the string.
  ///
  /// Example:
  /// ```dart
  /// '     He   llo wor   ld'.removeDuplicateWhiteSpace(); // 'He llo wor ld'
  /// ```
  String removeDuplicateWhiteSpace() {
    return replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Remove all white spaces in the string.
  ///
  /// Example:
  /// ```dart
  /// '     He   llo wor   ld'.removeAllWhiteSpace(); // 'Helloworld'
  /// ```
  String removeAllWhiteSpace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Replace all new line characters with '\n'.
  ///
  /// Example:
  /// ```dart
  /// 'Hello\nWorld'.replaceNewLine();
  /// // Hello
  /// // World
  /// 'Hello\r\nWorld'.replaceNewLine();
  /// // Hello
  /// // World
  /// r'Hello\r\nWorld'.replaceNewLine();
  /// // Hello\r\nWorld
  /// ```
  String replaceNewLine() {
    return replaceAll(RegExp(r'\n|\r\n'), '\n');
  }

  /// Capitalize the first letter of the string.
  ///
  /// Example:
  /// ```dart
  /// 'hello world'.capitalizeFirstLetter(); // 'Hello world'
  /// 'hello World'.capitalizeFirstLetter(); // 'Hello World
  /// 'h'.capitalizeFirstLetter(); // 'H'
  /// ```
  String capitalizeFirstLetter() {
    return isEmptyOrNull ? '' : substring(0, 1).toUpperCase() + substring(1);
  }

  /// Capitalize the first letter of each sentence in the string.
  /// A sentence is defined as a string that ends with '.', '!', or '?'.
  ///
  /// Example:
  /// ```dart
  /// 'hello world'.capitalizeFirstLetterOfSentence(); // 'Hello world'
  /// 'hello World'.capitalizeFirstLetterOfSentence(); // 'Hello World'
  /// 'h'.capitalizeFirstLetterOfSentence(); // 'H'
  /// 'trường đại học Công nghệ thông tin. hòa Bình, thủ đô Hà Nội.'.capitalizeFirstLetterOfSentence();
  /// // 'Trường đại học Công nghệ thông tin. Hòa Bình, thủ đô Hà Nội.'
  /// 'hello. world. hello. world'.capitalizeFirstLetterOfSentence(); // 'Hello. World. Hello. World'
  /// '  đây là câu đầu.   đây là câu tiếp theo. và đây là câu cuối.  '.capitalizeFirstLetterOfSentence();
  /// // '  Đây là câu đầu.   Đây là câu tiếp theo. Và đây là câu cuối.  '
  /// ```
  String capitalizeFirstLetterOfSentence() {
    final RegExp sentenceRegExp = RegExp('[.!?]');

    return splitMapJoin(
      sentenceRegExp,
      onMatch: (match) => match.group(0) ?? '',
      onNonMatch: (nonMatch) {
        if (nonMatch.isEmpty) {
          return nonMatch;
        }

        final int index = nonMatch.removeDiacritics().indexOf(RegExp('[a-zA-Z]'));

        if (index >= 0) {
          return nonMatch.replaceRange(index, index + 1, nonMatch[index].toUpperCase());
        }

        return nonMatch;
      },
    );
  }

  /// Capitalize the first letter of each word in the string.
  ///
  /// Example:
  /// ```dart
  /// 'hello world'.capitalizeEachWord(); // 'Hello World'
  /// 'hello World'.capitalizeEachWord(); // 'Hello World'
  /// 'h'.capitalizeEachWord(); // 'H'
  /// ```
  String capitalizeEachWord() {
    return split(' ').map((word) {
      if (word.isEmpty) {
        return word;
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  /// Replace all diacritics in the string.
  ///
  /// Example:
  /// ```dart
  /// 'Việt Nam'.removeDiacritics(); // 'Viet Nam'
  /// ```
  String removeDiacritics() {
    return diacritic.removeDiacritics(this);
  }
}
