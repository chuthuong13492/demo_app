import 'dart:convert' show jsonDecode;

import '../../../extensions.dart';

/// Object convert extension
extension ObjectConvertExt on Object? {
  /// Converts to string or null.
  String? toStringOrNull() {
    if (this == null) return null;

    return this!.toString();
  }

  /// Converts to int or null.
  int? toIntOrNull() {
    if (this == null) return null;
    if (this is num) return (this! as num).toInt();
    if (this is bool) return (this! as bool).toIntOrNull();
    if (this is String) return toStringOrNull().toIntOrNull();

    return null;
  }

  /// Converts to int or default value.
  int toInt({
    int defaultValue = 0,
  }) {
    return toIntOrNull().validate(defaultValue: defaultValue);
  }

  /// Converts to double or null
  double? toDoubleOrNull() {
    if (this == null) return null;
    if (this is num) return (this! as num).toDouble();
    if (this is bool) return (this! as bool).toDoubleOrNull();
    if (this is String) return toStringOrNull().toDoubleOrNull();
    return null;
  }

  /// Converts to double or default value.
  double toDouble({
    double defaultValue = 0.0,
  }) {
    return toDoubleOrNull().validate(defaultValue: defaultValue);
  }

  /// Converts to bool or null
  bool? toBoolOrNull() {
    if (this == null) return null;
    if (this is bool) return this! as bool;

    return toStringOrNull().toBoolOrNull();
  }

  /// Converts to bool or default value.
  bool toBool({
    bool defaultValue = false,
  }) {
    return toBoolOrNull().validate(defaultValue: defaultValue);
  }

  /// Converts to DateTime or null.
  DateTime? toDateTimeOrNull() {
    if (this == null) return null;
    if (this is DateTime) return this! as DateTime;
    if (this is num) return (this! as num).toDateTimeOrNull();
    if (this is String) return (this! as String).toDateTimeOrNull();

    return null;
  }

  /// Converts to DateTime or default value.
  DateTime toDateTime({
    required DateTime defaultValue,
  }) {
    return toDateTimeOrNull().validate(defaultValue: defaultValue);
  }

  /// Converts to DateTime (Date only) or null.
  DateTime? toDateOrNull() {
    return toDateTimeOrNull().toDateOrNull();
  }

  /// Converts to DateTime (Date only) or default value.
  DateTime toDate({
    required DateTime defaultValue,
  }) {
    return toDateTimeOrNull().toDate(defaultValue: defaultValue);
  }

  /// Converts to DateTime (Time only) or null.
  DateTime? toTimeOrNull({
    bool second = false,
    bool millisecond = false,
    bool microsecond = false,
  }) {
    return toDateTimeOrNull().toTimeOrNull(
      second: second,
      millisecond: millisecond,
      microsecond: microsecond,
    );
  }

  /// Converts to DateTime (Time only) or default value.
  DateTime toTime({
    required DateTime defaultValue,
    bool second = false,
    bool millisecond = false,
    bool microsecond = false,
  }) {
    return toDateTimeOrNull().toTime(
      defaultValue: defaultValue,
      second: second,
      millisecond: millisecond,
      microsecond: microsecond,
    );
  }

  /// Converts to List`<T>` or null.
  List<T>? toListOrNull<T extends Object?>() {
    if (this == null) return null;

    Iterable? base;

    if (this is Iterable) {
      base = (this! as Iterable);
    } else if (this is String && (this! as String).maybeJsonArray) {
      try {
        base = (jsonDecode(this! as String) as Object?).toListOrNull<Object?>();
      } catch (_) {}
    } else {
      base = Iterable.generate(1, (_) => this);
    }

    if (base == null) return null;
    if (base.isEmpty) return [];

    final List<T> list = [];

    for (var item in base) {
      if (isTypeOrNullableType<String, T>() && item is! String) {
        item = (item as Object?).toStringOrNull();
      } else if (isTypeOrNullableType<int, T>() && item is! int) {
        item = (item as Object?).toIntOrNull();
      } else if (isTypeOrNullableType<double, T>() && item is! double) {
        item = (item as Object?).toDoubleOrNull();
      } else if (isTypeOrNullableType<bool, T>() && item is! bool) {
        item = (item as Object?).toBoolOrNull();
      } else if (isTypeOrNullableType<DateTime, T>() && item is! DateTime) {
        item = (item as Object?).toDateTimeOrNull();
      } else if (isTypeOrNullableType<List, T>() && item is! List) {
        item = (item as Object?).toListOrNull();
      } else if (isTypeOrNullableType<Map, T>() && item is! Map) {
        item = (item as Object?).toMapOrNull();
      }

      if (item is T || (item == null && null is T)) {
        list.add(item);
      }
    }

    if (list.isEmpty) return null;

    return list;
  }

  /// Converts to List`<T>` or default value.
  List<T> toList<T extends Object?>({
    List<T> defaultValue = const [],
  }) {
    return toListOrNull<T>().validate(defaultValue: defaultValue);
  }

  /// Converts to Set`<T>` or null.
  Set<T>? toSetOrNull<T extends Object?>() {
    return toListOrNull<T>()?.toSet();
  }

  /// Converts to Set`<T>` or default value.
  Set<T> toSet<T extends Object?>({
    Set<T> defaultValue = const {},
  }) {
    return toSetOrNull<T>().validate(defaultValue: defaultValue);
  }

  /// Converts to Map`<K, V>` or null.
  Map<K, V>? toMapOrNull<K extends Object?, V extends Object?>() {
    if (this == null) return null;

    Map? base;

    if (this is Map) {
      base = (this! as Map);
    } else if (this is String && (this! as String).maybeJsonObject) {
      base = (this! as String).toJsonOrNull();
    }

    if (base == null) return null;
    if (base.isEmpty) return {};

    final Map<K, V> map = {};

    for (final item in base.entries) {
      var key = item.key;
      var value = item.value;

      if (isTypeOrNullableType<String, K>() && key is! String) {
        key = (key as Object?).toStringOrNull();
      } else if (isTypeOrNullableType<int, K>() && key is! int) {
        key = (key as Object?).toIntOrNull();
      } else if (isTypeOrNullableType<double, K>() && key is! double) {
        key = (key as Object?).toDoubleOrNull();
      } else if (isTypeOrNullableType<bool, K>() && key is! bool) {
        key = (key as Object?).toBoolOrNull();
      } else if (isTypeOrNullableType<DateTime, K>() && key is! DateTime) {
        key = (key as Object?).toDateTimeOrNull();
      }

      if (isTypeOrNullableType<String, V>() && value is! String) {
        value = (value as Object?).toStringOrNull();
      } else if (isTypeOrNullableType<int, V>() && value is! int) {
        value = (value as Object?).toIntOrNull();
      } else if (isTypeOrNullableType<double, V>() && value is! double) {
        value = (value as Object?).toDoubleOrNull();
      } else if (isTypeOrNullableType<bool, V>() && value is! bool) {
        value = (value as Object?).toBoolOrNull();
      } else if (isTypeOrNullableType<DateTime, V>() && value is! DateTime) {
        value = (value as Object?).toDateTimeOrNull();
      } else if (isTypeOrNullableType<List, V>() && value is! List) {
        value = (value as Object?).toListOrNull();
      } else if (isTypeOrNullableType<Map, V>() && value is! Map) {
        value = (value as Object?).toMapOrNull();
      }

      if ((key is K || (key == null && null is K)) && (value is V || (value == null && null is V))) {
        map[key] = value;
      }
    }

    if (map.isEmpty) return null;

    return map;
  }

  /// Converts to Map`<K, V>` or default value.
  Map<K, V> toMap<K extends Object?, V extends Object?>({
    Map<K, V> defaultValue = const {},
  }) {
    return toMapOrNull<K, V>().validate(defaultValue: defaultValue);
  }

  /// Converts to Map`<String, Object?>` or null.
  Map<String, Object?>? toJsonOrNull() {
    if (this == null) return null;
    if (this is String) {
      try {
        return (jsonDecode(this! as String) as Object?).toMapOrNull<String, Object?>();
      } catch (_) {
        return null;
      }
    }
    return toMapOrNull<String, Object?>();
  }

  /// Converts to Map`<String, Object?>` or default value.
  Map<String, Object?> toJson({
    Map<String, Object?> defaultValue = const {},
  }) {
    return toJsonOrNull().validate(defaultValue: defaultValue);
  }

  /// Converts to `<T>` or null
  ///
  /// - [String], [int], [double], [bool], [DateTime] is supported.
  ///
  /// - [List], [List<Object>], [List<String>], [List<int>], [List<double>], [List<bool>], [List<DateTime>] is supported.
  ///
  /// - [Set], [Set<Object>], [Set<String>], [Set<int>], [Set<double>], [Set<bool>], [Set<DateTime>] is supported.
  ///
  /// - [Map],  [Map<String, Object>] is supported.
  T? toObjectOrNull<T extends Object?>() {
    if (this == null) return null;

    if (isTypeOrNullableType<Object, T>() && this is String && (this! as String).maybeJsonObject) {
      final T? value = (this! as String).toJsonOrNull() as T?;
      if (value != null) return value;
    }
    if (isTypeOrNullableType<Object, T>() && this is String && (this! as String).maybeJsonArray) {
      final T? value = (this! as String).toListOrNull() as T?;
      if (value != null) return value;
    }

    if (this is T) return this as T;

    if (isTypeOrNullableType<String, T>()) return toStringOrNull() as T?;
    if (isTypeOrNullableType<int, T>()) return toIntOrNull() as T?;
    if (isTypeOrNullableType<double, T>()) return toDoubleOrNull() as T?;
    if (isTypeOrNullableType<bool, T>()) return toBoolOrNull() as T?;
    if (isTypeOrNullableType<DateTime, T>()) return toDateTimeOrNull() as T?;

    // List
    if (isTypeOrNullableType<List, T>()) return toListOrNull() as T?;
    // List<Object>
    if (isTypeOrNullableType<List<Object>, T>()) return toListOrNull<Object>() as T?;
    if (isTypeOrNullableType<List<Object?>, T>()) return toListOrNull<Object?>() as T?;
    // List<String>
    if (isTypeOrNullableType<List<String>, T>()) return toListOrNull<String>() as T?;
    if (isTypeOrNullableType<List<String?>, T>()) return toListOrNull<String?>() as T?;
    // List<int>
    if (isTypeOrNullableType<List<int>, T>()) return toListOrNull<int>() as T?;
    if (isTypeOrNullableType<List<int?>, T>()) return toListOrNull<int?>() as T?;
    // List<double>
    if (isTypeOrNullableType<List<double>, T>()) return toListOrNull<double>() as T?;
    if (isTypeOrNullableType<List<double?>, T>()) return toListOrNull<double?>() as T?;
    // List<bool>
    if (isTypeOrNullableType<List<bool>, T>()) return toListOrNull<bool>() as T?;
    if (isTypeOrNullableType<List<bool?>, T>()) return toListOrNull<bool?>() as T?;
    // List<DateTime>
    if (isTypeOrNullableType<List<DateTime>, T>()) return toListOrNull<DateTime>() as T?;
    if (isTypeOrNullableType<List<DateTime?>, T>()) return toListOrNull<DateTime?>() as T?;

    // Set
    if (isTypeOrNullableType<Set, T>()) return toSetOrNull() as T?;
    // Set<Object>
    if (isTypeOrNullableType<Set<Object>, T>()) return toSetOrNull<Object>() as T?;
    if (isTypeOrNullableType<Set<Object?>, T>()) return toSetOrNull<Object?>() as T?;
    // Set<String>
    if (isTypeOrNullableType<Set<String>, T>()) return toSetOrNull<String>() as T?;
    if (isTypeOrNullableType<Set<String?>, T>()) return toSetOrNull<String?>() as T?;
    // Set<int>
    if (isTypeOrNullableType<Set<int>, T>()) return toSetOrNull<int>() as T?;
    if (isTypeOrNullableType<Set<int?>, T>()) return toSetOrNull<int?>() as T?;
    // Set<double>
    if (isTypeOrNullableType<Set<double>, T>()) return toSetOrNull<double>() as T?;
    if (isTypeOrNullableType<Set<double?>, T>()) return toSetOrNull<double?>() as T?;
    // Set<bool>
    if (isTypeOrNullableType<Set<bool>, T>()) return toSetOrNull<bool>() as T?;
    if (isTypeOrNullableType<Set<bool?>, T>()) return toSetOrNull<bool?>() as T?;
    // Set<DateTime>
    if (isTypeOrNullableType<Set<DateTime>, T>()) return toSetOrNull<DateTime>() as T?;
    if (isTypeOrNullableType<Set<DateTime?>, T>()) return toSetOrNull<DateTime?>() as T?;

    // Map
    if (isTypeOrNullableType<Map, T>()) return toMapOrNull() as T?;
    // Map<String, Object>
    if (isTypeOrNullableType<Map<String, Object>, T>()) return toMapOrNull<String, Object>() as T?;
    if (isTypeOrNullableType<Map<String, Object?>, T>()) return toMapOrNull<String, Object?>() as T?;

    return null;
  }

  /// Converts to` <T>` or default value
  T toObject<T extends Object?>({
    required T defaultValue,
  }) {
    return toObjectOrNull<T>() ?? defaultValue;
  }
}
