import 'string_format.dart';

final RegExp _email = RegExp(
  r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$",
);
// RegExp _oldEmail = RegExp(r'^[a-zA-Z0-9]+(?:(\+|[\.\-_])[a-zA-Z0-9]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$');

final RegExp _phone = RegExp(r'^(\+)?([ 0-9]){10,16}$');

final RegExp _image = RegExp(r'.(jpeg|jpg|gif|png|bmp|heic|tiff)$');

final RegExp _audio = RegExp(r'.(mp3|wav|wma|amr|ogg)$');

final RegExp _video = RegExp(r'.(mp4|avi|wmv|rmvb|mpg|mpeg|3gp|mkv|mov)$');

final RegExp _txt = RegExp(r'.txt$');

final RegExp _doc = RegExp(r'.(doc|docx)$');

final RegExp _excel = RegExp(r'.(xls|xlsx)$');

final RegExp _powerpoint = RegExp(r'.(ppt|pptx)$');

final RegExp _pdf = RegExp(r'.pdf$');

final RegExp _html = RegExp(r'.html$');

final RegExp _asset = RegExp(r'^assets\/.+$');

final RegExp _svg = RegExp(r'<\s*svg[^>]*>(.*?)<\s*/\s*svg>');

final RegExp _svgFile = RegExp(r'.svg$');

final RegExp _htmlParagraph = RegExp(r'^(<p>)(.+?)(</p>)$');

final RegExp _jsonObject = RegExp(r'^\s*\{.*\}\s*$', dotAll: true);
final RegExp _jsonArray = RegExp(r'^\s*\[.*\]\s*$', dotAll: true);

final RegExp _ipv4Maybe = RegExp(r'^(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)$');
final RegExp _ipv6 = RegExp(r'^::|^::1|^([a-fA-F0-9]{1,4}::?){1,7}([a-fA-F0-9]{1,4})$');

final RegExp _surrogatePairsRegExp = RegExp(r'[\uD800-\uDBFF][\uDC00-\uDFFF]');

final RegExp _alpha = RegExp(r'^[a-zA-Z]+$');
final RegExp _alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
final RegExp _numeric = RegExp(r'^-?[0-9]+$');
final RegExp _int = RegExp(r'^(?:-?(?:0|[1-9][0-9]*))$');
final RegExp _double = RegExp(r'^(?:-?(?:[0-9]+))?(?:\.[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?$');
final RegExp _hexadecimal = RegExp(r'^[0-9a-fA-F]+$');
final RegExp _hexColor = RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
final RegExp _time = RegExp(r'^([01]\d|2[0-3]):[0-5]\d(:[0-5]\d(\.\d{1,3})?)?$');
final RegExp _boolean = RegExp(r'^(true|false|1|0|1\.0|0\.0)$', caseSensitive: false);

final RegExp _base64 = RegExp(r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$');

final RegExp _creditCard = RegExp(
  r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$',
);

final Map<String, RegExp> _uuid = {
  '3': RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-3[0-9A-F]{3}-[0-9A-F]{4}-[0-9A-F]{12}$'),
  '4': RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$'),
  '5': RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-5[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$'),
  'all': RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$'),
};

final RegExp _multibyte = RegExp(r'[^\x00-\x7F]');
final RegExp _ascii = RegExp(r'^[\x00-\x7F]+$');

String? _shift(List<String> elements) {
  if (elements.isEmpty) return null;
  return elements.removeAt(0);
}

Map<String, Object> _merge(
  Map<String, Object>? obj,
  Map<String, Object> defaults,
) {
  if (obj == null) {
    return defaults;
  }
  defaults.forEach((key, val) => obj.putIfAbsent(key, () => val));
  return obj;
}

/// String check extension
extension StringCheckExt on String? {
  /// Check if the string is null or empty.
  bool get isEmptyOrNull {
    if (this == null) return true;
    if (this!.isEmpty) return true;
    if (this!.toLowerCase() == 'null') return true;
    return false;
  }

  /// Check if the string is not null and not empty.
  bool get isNotEmptyAndNull => !isEmptyOrNull;

  /// check if the string is an email
  bool get isEmail {
    if (this == null) return false;
    return _email.hasMatch(this!.toLowerCase());
  }

  /// check if the string contains only letters (a-zA-Z).
  bool get isAlpha {
    if (this == null) return false;
    return _alpha.hasMatch(this!.removeDiacritics());
  }

  /// check if the string contains only numbers
  bool get isNumeric {
    if (this == null) return false;
    return _numeric.hasMatch(this!);
  }

  /// check if the string contains only letters and numbers
  bool get isAlphanumeric {
    if (this == null) return false;
    return _alphanumeric.hasMatch(this!);
  }

  /// check if a string is base64 encoded
  bool get isBase64 {
    if (this == null) return false;
    return _base64.hasMatch(this!);
  }

  /// check if the string is an integer
  bool get isInt {
    if (this == null) return false;
    return _int.hasMatch(this!);
  }

  /// check if the string is a double
  bool get isDouble {
    if (this == null) return false;
    return _double.hasMatch(this!);
  }

  /// check if the string is a time
  bool get isTime {
    if (this == null) return false;
    return _time.hasMatch(this!);
  }

  /// check if the string is a boolean
  bool get isBoolean {
    if (this == null) return false;
    return _boolean.hasMatch(this!);
  }

  /// check if the string is a hexadecimal number
  bool get isHexadecimal {
    if (this == null) return false;
    return _hexadecimal.hasMatch(this!);
  }

  /// check if the string is a hexadecimal color
  bool get isHexColor {
    if (this == null) return false;
    return _hexColor.hasMatch(this!);
  }

  /// check if the string is lowercase
  bool get isLowercase {
    if (this == null) return false;
    return this == this!.toLowerCase();
  }

  /// check if the string is uppercase
  bool get isUppercase {
    if (this == null) return false;
    return this == this!.toUpperCase();
  }

  /// Check if the string is a valid image url.
  bool get isImage {
    if (this == null) return false;
    return _image.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid audio url.
  bool get isAudio {
    if (this == null) return false;
    return _audio.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid video url.
  bool get isVideo {
    if (this == null) return false;
    return _video.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid phone number.
  bool get isPhone {
    if (this == null) return false;
    return _phone.hasMatch(this!);
  }

  /// Check if the string is a valid html code
  bool get isHtml {
    if (this == null) return false;
    return _html.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid asset url.
  bool get isAsset {
    if (this == null) return false;
    return _asset.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid text file url.
  bool get isTxt {
    if (this == null) return false;
    return _txt.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid word file url.
  bool get isDoc {
    if (this == null) return false;
    return _doc.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid excel file url.
  bool get isExcel {
    if (this == null) return false;
    return _excel.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid powerpoint file url.
  bool get isPpt {
    if (this == null) return false;
    return _powerpoint.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid pdf file url.
  bool get isPdf {
    if (this == null) return false;
    return _pdf.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid svg code.
  bool get isSvg {
    if (this == null) return false;
    return _svg.hasMatch(this!);
  }

  /// Check if the string is a valid svg file url.
  bool get isSvgFile {
    if (this == null) return false;
    return _svgFile.hasMatch(this!.toLowerCase());
  }

  /// Check if the string is a valid html paragraph.
  bool get isHtmlParagraph {
    if (this == null) return false;
    return _htmlParagraph.hasMatch(this!);
  }

  /// check if the string's length falls in a range
  /// If no max is given then any length above min is ok.
  ///
  /// Note: this function takes into account surrogate pairs.
  bool isLength(int min, [int? max]) {
    final surrogatePairs = _surrogatePairsRegExp.allMatches(this ?? '').toList();
    final int len = (this ?? '').length - surrogatePairs.length;
    return len >= min && (max == null || len <= max);
  }

  /// check if the string's length (in bytes) falls in a range.
  bool isByteLength(int min, [int? max]) {
    return (this ?? '').length >= min && (max == null || (this ?? '').length <= max);
  }

  /// check if the string is a UUID (version 3, 4 or 5).
  bool isUUID([Object? version]) {
    if (this == null) return false;
    if (version == null) {
      version = 'all';
    } else {
      version = version.toString();
    }

    final RegExp? pat = _uuid[version];
    return (pat != null && pat.hasMatch(this!.toUpperCase()));
  }

  /// check if the string is in an array of allowed values
  bool isIn(Object? values) {
    if (this == null) return false;
    if (values == null) return false;
    if (values is String) {
      return values.contains(this!);
    }
    if (values is! Iterable) return false;
    for (final Object? value in values) {
      if (value.toString() == this!) return true;
    }
    return false;
  }

  /// check if the string maybe a JSON object
  ///
  /// Note: this function only checks it maybe a JSON object, it does not check if it's a valid JSON object.
  /// To check if it's a valid JSON, try to decode it.
  bool get maybeJsonObject {
    if (this == null) return false;
    return _jsonObject.hasMatch(this!);
  }

  /// check if the string maybe a JSON array
  ///
  /// Note: this function only checks it maybe a JSON array, it does not check if it's a valid JSON array.
  /// To check if it's a valid JSON, try to decode it.
  bool get maybeJsonArray {
    if (this == null) return false;
    return _jsonArray.hasMatch(this!);
  }

  /// check if the string contains one or more multibyte chars
  bool get isMultibyte {
    if (this == null) return false;
    return _multibyte.hasMatch(this!);
  }

  /// check if the string contains ASCII chars only
  bool get isAscii {
    if (this == null) return false;
    return _ascii.hasMatch(this!);
  }

  /// check if the string contains any surrogate pairs chars
  bool get isSurrogatePair {
    if (this == null) return false;
    return _surrogatePairsRegExp.hasMatch(this!);
  }

  /// check if the string is a credit card
  bool get isCreditCard {
    if (this == null) return false;
    final String sanitized = this!.replaceAll(RegExp('[^0-9]+'), '');
    if (!_creditCard.hasMatch(sanitized)) {
      return false;
    }

    // Luhn algorithm
    int sum = 0;
    String digit;
    bool shouldDouble = false;

    for (int i = sanitized.length - 1; i >= 0; i--) {
      digit = sanitized.substring(i, (i + 1));
      int tmpNum = int.parse(digit);

      if (shouldDouble) {
        tmpNum *= 2;
        if (tmpNum >= 10) {
          sum += ((tmpNum % 10) + 1);
        } else {
          sum += tmpNum;
        }
      } else {
        sum += tmpNum;
      }
      shouldDouble = !shouldDouble;
    }

    return (sum % 10 == 0);
  }

  /// check if the string is a URL
  ///
  /// `options` is a `Map` which defaults to
  /// `{ 'protocols': ['http','https','ftp'], 'require_tld': true,
  /// 'require_protocol': false, 'allow_underscores': false }`.
  bool isURL([Map<String, Object>? options]) {
    if (this == null) return false;
    if (this!.isEmpty) return false;
    if (this!.length > 2083) return false;
    if (this!.indexOf('mailto:') == 0) return false;

    final defaultUrlOptions = {
      'protocols': ['http', 'https', 'ftp'],
      'require_tld': true,
      'require_protocol': false,
      'allow_underscores': false,
    };

    options = _merge(options, defaultUrlOptions);

    // check protocol
    List<String> split = this!.split('://');
    if (split.length > 1) {
      final protocol = _shift(split);
      final protocols = options['protocols']! as List<String>;
      if (!protocols.contains(protocol)) {
        return false;
      }
    } else if (options['require_protocol'] == true) {
      return false;
    }
    String? str = split.join('://');

    // check hash
    split = str.split('#');
    str = _shift(split);
    final hash = split.join('#');
    if (hash.isNotEmpty && RegExp(r'\s').hasMatch(hash)) {
      return false;
    }

    // check query params
    split = str?.split('?') ?? [];
    str = _shift(split);
    final query = split.join('?');
    if (query != '' && RegExp(r'\s').hasMatch(query)) {
      return false;
    }

    // check path
    split = str?.split('/') ?? [];
    str = _shift(split);
    final path = split.join('/');
    if (path != '' && RegExp(r'\s').hasMatch(path)) {
      return false;
    }

    // check auth type urls
    split = str?.split('@') ?? [];
    if (split.length > 1) {
      final auth = _shift(split);
      if (auth != null && auth.contains(':')) {
        // final auth = auth.split(':');
        final parts = auth.split(':');
        final user = _shift(parts);
        if (user == null || !RegExp(r'^\S+$').hasMatch(user)) {
          return false;
        }
        final pass = parts.join(':');
        if (!RegExp(r'^\S*$').hasMatch(pass)) {
          return false;
        }
      }
    }

    // check hostname
    final hostname = split.join('@');
    split = hostname.split(':');
    final host = _shift(split);
    if (split.isNotEmpty) {
      final portStr = split.join(':');
      final port = int.tryParse(portStr, radix: 10);
      if (!RegExp(r'^[0-9]+$').hasMatch(portStr) || port == null || port <= 0 || port > 65535) {
        return false;
      }
    }

    if (host == null || !host.isIP() && !host.isFQDN(options) && host != 'localhost') {
      return false;
    }

    return true;
  }

  /// check if the string is an IP (version 4 or 6)
  ///
  /// `version` is a String or an `int`.
  bool isIP([Object? version]) {
    if (this == null) return false;
    assert(version == null || version is String || version is int, 'version must be a String or an int');
    version = version.toString();
    if (version == 'null') {
      return isIP(4) || isIP(6);
    } else if (version == '4') {
      if (!_ipv4Maybe.hasMatch(this!)) {
        return false;
      }
      final parts = this!.split('.');
      parts.sort((a, b) => int.parse(a) - int.parse(b));
      return int.parse(parts[3]) <= 255;
    }
    return version == '6' && _ipv6.hasMatch(this!);
  }

  /// check if the string is a fully qualified domain name (e.g. domain.com).
  ///
  /// `options` is a `Map` which defaults to `{ 'require_tld': true, 'allow_underscores': false }`.
  bool isFQDN([Map<String, Object>? options]) {
    if (this == null) return false;
    final defaultFqdnOptions = {'require_tld': true, 'allow_underscores': false};

    options = _merge(options, defaultFqdnOptions);
    final parts = this!.split('.');
    if (options['require_tld']! as bool) {
      final tld = parts.removeLast();
      if (parts.isEmpty || !RegExp(r'^[a-z]{2,}$').hasMatch(tld)) {
        return false;
      }
    }

    for (final part in parts) {
      if (options['allow_underscores']! as bool) {
        if (part.contains('__')) {
          return false;
        }
      }
      if (!RegExp(r'^[a-z\\u00a1-\\uffff0-9-]+$').hasMatch(part)) {
        return false;
      }
      if (part[0] == '-' || part[part.length - 1] == '-' || part.contains('---')) {
        return false;
      }
    }
    return true;
  }
}
