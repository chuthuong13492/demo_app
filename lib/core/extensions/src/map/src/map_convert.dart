import '../../../extensions.dart';

/// Convert List to `<T>` function
typedef ConvertListTo<T> = T? Function(List<Object?> list);

/// Convert Map to `<T>` function
typedef ConvertMapTo<T> = T? Function(Map<Object?, Object?> map);

/// Convert Object to `<T>` function
typedef ConvertObjectTo<T> = T? Function(Object object);

Object? _findValue({
  required Map? map,
  required Object? key,
  required List<Object>? replaceKeys,
}) {
  if (map == null) return null;

  Object? value = map[key];

  if (value == null && replaceKeys != null && replaceKeys.isNotEmpty) {
    final List<Object> keys = List.of(replaceKeys);

    // find value not null from the replace keys
    while (value == null && keys.isNotEmpty) {
      key = keys.removeFirst();
      value = map[key];
    }
  }

  return value;
}

int _compareType(Object? a, Object? b, List<Type>? types) {
  if (types == null) return 0;

  int aPoint = types.length;
  int bPoint = types.length;

  for (int i = 0; i < types.length; i++) {
    if (a.runtimeType == types[i]) aPoint = i;
    if (b.runtimeType == types[i]) bPoint = i;
  }

  return aPoint.compareTo(bPoint);
}

/// Map convert extension
extension MapConvertExt on Map? {
  /// Get Map value or null
  ///
  /// [key] is the key to get the value from the map.
  ///
  /// [parentKeys] is the list of keys to get the value from the nested map.
  ///
  /// [replaceKeys] is the list of keys to replace the key if the key is not found in the map. Same level with [key].
  Map<K, V>? getMapOrNull<K extends Object?, V extends Object?>(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
  }) {
    if (this == null) return null;
    if (this!.isEmpty) return null;

    final Object? parentKey = parentKeys.removeFirst();

    if (parentKey != null) {
      return (this![parentKey] as Object?)?.toMapOrNull<K, V>()?.getMapOrNull(
        key,
        parentKeys: parentKeys,
        replaceKeys: replaceKeys,
      );
    }

    final Object? value = _findValue(map: this, key: key, replaceKeys: replaceKeys);

    return value?.toMapOrNull<K, V>();
  }

  /// Get Map value or default value
  ///
  /// [key] is the key to get the value from the map.
  ///
  /// [parentKeys] is the list of keys to get the value from the nested map.
  ///
  /// [replaceKeys] is the list of keys to replace the key if the key is not found in the map.
  ///
  /// [defaultValue] is the default value if the value is null.
  Map<K, V> getMap<K extends Object?, V extends Object?>(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
    Map<K, V> defaultValue = const {},
  }) {
    return getMapOrNull<K, V>(
      key,
      parentKeys: parentKeys,
      replaceKeys: replaceKeys,
    ).validate(defaultValue: defaultValue);
  }

  /// Get string value or null.
  ///
  /// [key] is the key to get the value from the map.
  ///
  /// [parentKeys] is the list of keys to get the value from the nested map.
  ///
  /// [replaceKeys] is the list of keys to replace the key if the key is not found in the map.
  ///
  /// - Same level with [key].
  ///
  /// [listToString] convert the value from the list/arry json to [String] or null
  ///
  /// - If not set, the default value will be the first [String] value from the list.
  ///
  /// [mapToString] convert the value from the map/object json to [String] or null.
  ///
  /// - If not set, the default value will be the [key] or [replaceKeys] or first [String] value from the map.
  ///
  /// [objectToString] convert the value from the object json to [String] or null.
  ///
  /// - If not set, the default value will be call [toStringOrNull] normal.
  String? getStringOrNull(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
    ConvertListTo<String>? listToString,
    ConvertMapTo<String>? mapToString,
    ConvertObjectTo<String>? objectToString,
  }) {
    if (this == null) return null;
    if (this!.isEmpty) return null;

    final Object? parentKey = parentKeys?.removeLast();

    if (parentKey != null) {
      return getMapOrNull(
        parentKey,
        parentKeys: parentKeys,
      )?.getStringOrNull(
        key,
        replaceKeys: replaceKeys,
        listToString: listToString,
        mapToString: mapToString,
        objectToString: objectToString,
      );
    }

    final Object? value = _findValue(map: this, key: key, replaceKeys: replaceKeys);

    // If the value is a list or string array json
    if (value is Iterable || (value is String && value.maybeJsonArray)) {
      final List<Object?>? list = value.toListOrNull<Object?>();

      if (listToString != null && list != null) return listToString(list);

      return list
          // sort the list by type
          ?.sorted((a, b) => _compareType(a, b, [String]))
          // default get first string value from the list
          .fold<String?>(null, (previousValue, element) => previousValue ?? element?.toStringOrNull());
    }
    // If the value is a map or string object json
    if (value is Map || (value is String && value.maybeJsonObject)) {
      final Map<Object?, Object?>? map = value.toMapOrNull<Object?, Object?>();

      if (mapToString != null && map != null) return mapToString(map);

      // default get the value with key or replace keys or first string value from the map.
      return map?.getStringOrNull(key, replaceKeys: replaceKeys) ??
          map?.values
              .toList()
              // sort the list by type
              .sorted((a, b) => _compareType(a, b, [String]))
              // default get first string value from the list
              .fold<String?>(null, (previousValue, element) => previousValue ?? element?.toStringOrNull());
    }

    if (value is! String && objectToString != null && value != null) return objectToString(value);

    return value?.toStringOrNull();
  }

  /// Get string value or default value
  ///
  /// [key] is the key to get the value from the map.
  ///
  /// [parentKeys] is the list of keys to get the value from the nested map.
  ///
  /// [replaceKeys] is the list of keys to replace the key if the key is not found in the map.
  ///
  /// - Same level with [key].
  ///
  /// [listToString] convert the value from the list/arry json to [String] or null
  ///
  /// - If not set, the default value will be the first [String] value from the list.
  ///
  /// [mapToString] convert the value from the map/object json to [String] or null.
  ///
  /// - If not set, the default value will be the [key] or [replaceKeys] or first [String] value from the map.
  ///
  /// [objectToString] convert the value from the object json to [String] or null.
  ///
  /// - If not set, the default value will be call [toStringOrNull] normal.
  ///
  /// [defaultValue] is the default value if the value is null.
  String getString(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
    ConvertListTo<String>? listToString,
    ConvertMapTo<String>? mapToString,
    ConvertObjectTo<String>? objectToString,
    String defaultValue = '',
  }) {
    return getStringOrNull(
      key,
      parentKeys: parentKeys,
      replaceKeys: replaceKeys,
      listToString: listToString,
      mapToString: mapToString,
      objectToString: objectToString,
    ).validate(defaultValue: defaultValue);
  }

  /// Get int value or null.
  ///
  /// [key] is the key to get the value from the map.
  ///
  /// [parentKeys] is the list of keys to get the value from the nested map.
  ///
  /// [replaceKeys] is the list of keys to replace the key if the key is not found in the map.
  ///
  /// - Same level with [key].
  ///
  /// [listToInt] convert the value from the list/arry json to [int] or null
  ///
  /// - If not set, the default value will be the first [int] value from the list.
  ///
  /// [mapToInt] convert the value from the map/object json to [int] or null.
  ///
  /// - If not set, the default value will be the [key] or [replaceKeys] or first [int] value from the map.
  ///
  /// [objectToInt] convert the value from the object json to [int] or null.
  ///
  /// - If not set, the default value will be call [toIntOrNull] normal.
  int? getIntOrNull(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
    ConvertListTo<int>? listToInt,
    ConvertMapTo<int>? mapToInt,
    ConvertObjectTo<int>? objectToInt,
  }) {
    if (this == null) return null;
    if (this!.isEmpty) return null;

    final Object? parentKey = parentKeys?.removeLast();

    if (parentKey != null) {
      return getMapOrNull(
        parentKey,
        parentKeys: parentKeys,
      )?.getIntOrNull(
        key,
        replaceKeys: replaceKeys,
        listToInt: listToInt,
        mapToInt: mapToInt,
        objectToInt: objectToInt,
      );
    }

    final Object? value = _findValue(map: this, key: key, replaceKeys: replaceKeys);

    // If the value is a list or string array json
    if (value is Iterable || (value is String && value.maybeJsonArray)) {
      final List<Object?>? list = value.toListOrNull<Object?>();

      if (listToInt != null && list != null) return listToInt(list);

      return list
          // sort the list by type
          ?.sorted((a, b) => _compareType(a, b, [int, double, String]))
          // default get first int value from the list
          .fold<int?>(null, (previousValue, element) => previousValue ?? element?.toIntOrNull());
    }
    // If the value is a map or string object json
    if (value is Map || (value is String && value.maybeJsonObject)) {
      final Map<Object?, Object?>? map = value.toMapOrNull<Object?, Object?>();

      if (mapToInt != null && map != null) return mapToInt(map);

      // default get the value with key or replace keys or first int value from the map.
      return map?.getIntOrNull(key, replaceKeys: replaceKeys) ??
          map?.values
              .toList()
              // sort the list by type
              .sorted((a, b) => _compareType(a, b, [int, double, String]))
              // default get first int value from the list
              .fold<int?>(null, (previousValue, element) => previousValue ?? element?.toIntOrNull());
    }

    if (value is! num && objectToInt != null && value != null) return objectToInt(value);

    return value?.toIntOrNull();
  }

  /// Get int value or default value.
  ///
  /// [key] is the key to get the value from the map.
  ///
  /// [parentKeys] is the list of keys to get the value from the nested map.
  ///
  /// [replaceKeys] is the list of keys to replace the key if the key is not found in the map.
  ///
  /// - Same level with [key].
  ///
  /// [listToInt] convert the value from the list/arry json to [int] or null
  ///
  /// - If not set, the default value will be the first [int] value from the list.
  ///
  /// [mapToInt] convert the value from the map/object json to [int] or null.
  ///
  /// - If not set, the default value will be the [key] or [replaceKeys] or first [int] value from the map.
  ///
  /// [objectToInt] convert the value from the object json to [int] or null.
  ///
  /// - If not set, the default value will be call [toIntOrNull] normal.
  ///
  /// [defaultValue] is the default value if the value is null.
  int getInt(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
    ConvertListTo<int>? listToInt,
    ConvertMapTo<int>? mapToInt,
    ConvertObjectTo<int>? objectToInt,
    int defaultValue = 0,
  }) {
    return getIntOrNull(
      key,
      parentKeys: parentKeys,
      replaceKeys: replaceKeys,
      listToInt: listToInt,
      mapToInt: mapToInt,
      objectToInt: objectToInt,
    ).validate(defaultValue: defaultValue);
  }

  /// Get double value or null.
  ///
  /// [key] is the key to get the value from the map.
  ///
  /// [parentKeys] is the list of keys to get the value from the nested map.
  ///
  /// [replaceKeys] is the list of keys to replace the key if the key is not found in the map.
  ///
  /// - Same level with [key].
  ///
  /// [listToDouble] convert the value from the list/arry json to [double] or null
  ///
  /// - If not set, the default value will be the first [double] value from the list.
  ///
  /// [mapToDouble] convert the value from the map/object json to [double] or null.
  ///
  /// - If not set, the default value will be the [key] or [replaceKeys] or first [double] value from the map.
  ///
  /// [objectToDouble] convert the value from the object json to [double] or null.
  ///
  /// - If not set, the default value will be call [toDoubleOrNull] normal.
  double? getDoubleOrNull(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
    ConvertListTo<double>? listToDouble,
    ConvertMapTo<double>? mapToDouble,
    ConvertObjectTo<double>? objectToDouble,
  }) {
    if (this == null) return null;
    if (this!.isEmpty) return null;

    final Object? parentKey = parentKeys?.removeLast();

    if (parentKey != null) {
      return getMapOrNull(
        parentKey,
        parentKeys: parentKeys,
      )?.getDoubleOrNull(
        key,
        replaceKeys: replaceKeys,
        listToDouble: listToDouble,
        mapToDouble: mapToDouble,
        objectToDouble: objectToDouble,
      );
    }

    final Object? value = _findValue(map: this, key: key, replaceKeys: replaceKeys);

    // If the value is a list or string array json
    if (value is Iterable || (value is String && value.maybeJsonArray)) {
      final List<Object?>? list = value.toListOrNull<Object?>();

      if (listToDouble != null && list != null) return listToDouble(list);

      return list
          // sort the list by type
          ?.sorted((a, b) => _compareType(a, b, [double, int, String]))
          // default get first double value from the list
          .fold<double?>(null, (previousValue, element) => previousValue ?? element?.toDoubleOrNull());
    }
    // If the value is a map or string object json
    if (value is Map || (value is String && value.maybeJsonObject)) {
      final Map<Object?, Object?>? map = value.toMapOrNull<Object?, Object?>();

      if (mapToDouble != null && map != null) return mapToDouble(map);

      // default get the value with key or replace keys or first double value from the map.
      return map?.getDoubleOrNull(key, replaceKeys: replaceKeys) ??
          map?.values
              .toList()
              // sort the list by type
              .sorted((a, b) => _compareType(a, b, [double, int, String]))
              // default get first double value from the list
              .fold<double?>(null, (previousValue, element) => previousValue ?? element?.toDoubleOrNull());
    }

    if (value is! num && objectToDouble != null && value != null) return objectToDouble(value);

    return value?.toDoubleOrNull();
  }

  /// Get double value or default value.
  ///
  /// [key] is the key to get the value from the map.
  ///
  /// [parentKeys] is the list of keys to get the value from the nested map.
  ///
  /// [replaceKeys] is the list of keys to replace the key if the key is not found in the map.
  ///
  /// - Same level with [key].
  ///
  /// [listToDouble] convert the value from the list/arry json to [double] or null
  ///
  /// - If not set, the default value will be the first [double] value from the list.
  ///
  /// [mapToDouble] convert the value from the map/object json to [double] or null.
  ///
  /// - If not set, the default value will be the [key] or [replaceKeys] or first [double] value from the map.
  ///
  /// [objectToDouble] convert the value from the object json to [double] or null.
  ///
  /// - If not set, the default value will be call [toDoubleOrNull] normal.
  ///
  /// [defaultValue] is the default value if the value is null.
  double getDouble(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
    ConvertListTo<double>? listToDouble,
    ConvertMapTo<double>? mapToDouble,
    ConvertObjectTo<double>? objectToDouble,
    double defaultValue = 0.0,
  }) {
    return getDoubleOrNull(
      key,
      parentKeys: parentKeys,
      replaceKeys: replaceKeys,
      listToDouble: listToDouble,
      mapToDouble: mapToDouble,
      objectToDouble: objectToDouble,
    ).validate(defaultValue: defaultValue);
  }

  /// Get bool value or null.
  ///
  /// [key] is the key to get the value from the map.
  ///
  /// [parentKeys] is the list of keys to get the value from the nested map.
  ///
  /// [replaceKeys] is the list of keys to replace the key if the key is not found in the map.
  ///
  /// - Same level with [key].
  ///
  /// [listToBool] convert the value from the list/arry json to [bool] or null
  ///
  /// - If not set, the default value will be the first [bool] value from the list.
  ///
  /// [mapToBool] convert the value from the map/object json to [bool] or null.
  ///
  /// - If not set, the default value will be the [key] or [replaceKeys] or first [bool] value from the map.
  ///
  /// [objectToBool] convert the value from the object json to [bool] or null.
  ///
  /// - If not set, the default value will be call [toBoolOrNull] normal.
  bool? getBoolOrNull(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
    ConvertListTo<bool>? listToBool,
    ConvertMapTo<bool>? mapToBool,
    ConvertObjectTo<bool>? objectToBool,
  }) {
    if (this == null) return null;
    if (this!.isEmpty) return null;

    final Object? parentKey = parentKeys?.removeLast();

    if (parentKey != null) {
      return getMapOrNull(
        parentKey,
        parentKeys: parentKeys,
      )?.getBoolOrNull(
        key,
        replaceKeys: replaceKeys,
        listToBool: listToBool,
        mapToBool: mapToBool,
        objectToBool: objectToBool,
      );
    }

    final Object? value = _findValue(map: this, key: key, replaceKeys: replaceKeys);

    // If the value is a list or string array json
    if (value is Iterable || (value is String && value.maybeJsonArray)) {
      final List<Object?>? list = value.toListOrNull<Object?>();

      if (listToBool != null && list != null) return listToBool(list);

      // default get first boolean value from the list
      return list
          // sort the list by type
          ?.sorted((a, b) => _compareType(a, b, [bool, int, double, String]))
          // default get first boolean value from the list
          .fold<bool?>(null, (previousValue, element) => previousValue ?? element?.toBoolOrNull());
    }
    // If the value is a map or string object json
    if (value is Map || (value is String && value.maybeJsonObject)) {
      final Map<Object?, Object?>? map = value.toMapOrNull<Object?, Object?>();

      if (mapToBool != null && map != null) return mapToBool(map);

      // default get the value with key or replace keys or first boolean value from the map.
      return map?.getBoolOrNull(key, replaceKeys: replaceKeys) ??
          map?.values
              .toList()
              // sort the list by type
              .sorted((a, b) => _compareType(a, b, [bool, int, double, String]))
              // default get first boolean value from the list
              .fold<bool?>(null, (previousValue, element) => previousValue ?? element?.toBoolOrNull());
    }

    if (value is! bool && objectToBool != null && value != null) return objectToBool(value);

    return value?.toBoolOrNull();
  }

  /// Get bool value or default value.
  ///
  /// [key] is the key to get the value from the map.
  ///
  /// [parentKeys] is the list of keys to get the value from the nested map.
  ///
  /// [replaceKeys] is the list of keys to replace the key if the key is not found in the map.
  ///
  /// - Same level with [key].
  ///
  /// [listToBool] convert the value from the list/arry json to [bool] or null
  ///
  /// - If not set, the default value will be the first [bool] value from the list.
  ///
  /// [mapToBool] convert the value from the map/object json to [bool] or null.
  ///
  /// - If not set, the default value will be the [key] or [replaceKeys] or first [bool] value from the map.
  ///
  /// [objectToBool] convert the value from the object json to [bool] or null.
  ///
  /// - If not set, the default value will be call [toBoolOrNull] normal.
  ///
  /// [defaultValue] is the default value if the value is null.
  bool getBool(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
    ConvertListTo<bool>? listToBool,
    ConvertMapTo<bool>? mapToBool,
    ConvertObjectTo<bool>? objectToBool,
    bool defaultValue = false,
  }) {
    return getBoolOrNull(
      key,
      parentKeys: parentKeys,
      replaceKeys: replaceKeys,
      listToBool: listToBool,
      mapToBool: mapToBool,
      objectToBool: objectToBool,
    ).validate(defaultValue: defaultValue);
  }

  /// Get DateTime - DateTime(year, month, day, hour, minute, second, millisecond, microsecond) value or null.
  ///
  /// [key] is the key to get the value from the map.
  ///
  /// [parentKeys] is the list of keys to get the value from the nested map.
  ///
  /// [replaceKeys] is the list of keys to replace the key if the key is not found in the map.
  ///
  /// - Same level with [key].
  ///
  /// [listToDateTime] convert the value from the list/arry json to [DateTime] or null
  ///
  /// - If not set, the default value will be the first [DateTime] value from the list.
  ///
  /// [mapToDateTime] convert the value from the map/object json to [DateTime] or null.
  ///
  /// - If not set, the default value will be the [key] or [replaceKeys] or first [DateTime] value from the map.
  ///
  /// [objectToDateTime] convert the value from the object json to [DateTime] or null.
  ///
  /// - If not set, the default value will be call [toDateTimeOrNull] normal.
  DateTime? getDateTimeOrNull(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
    ConvertListTo<DateTime>? listToDateTime,
    ConvertMapTo<DateTime>? mapToDateTime,
    ConvertObjectTo<DateTime>? objectToDateTime,
  }) {
    if (this == null) return null;
    if (this!.isEmpty) return null;

    final Object? parentKey = parentKeys?.removeLast();

    if (parentKey != null) {
      return getMapOrNull(
        parentKey,
        parentKeys: parentKeys,
      )?.getDateTimeOrNull(
        key,
        replaceKeys: replaceKeys,
        listToDateTime: listToDateTime,
        mapToDateTime: mapToDateTime,
        objectToDateTime: objectToDateTime,
      );
    }

    final Object? value = _findValue(map: this, key: key, replaceKeys: replaceKeys);

    // If the value is a list or string array json
    if (value is Iterable || (value is String && value.maybeJsonArray)) {
      final List<Object?>? list = value.toListOrNull<Object?>();

      if (listToDateTime != null && list != null) return listToDateTime(list);

      return list
          // sort the list by type
          ?.sorted((a, b) => _compareType(a, b, [DateTime, String, num]))
          // default get first date time value from the list
          .fold<DateTime?>(null, (previousValue, element) => previousValue ?? element?.toDateTimeOrNull());
    }
    // If the value is a map or string object json
    if (value is Map || (value is String && value.maybeJsonObject)) {
      final Map<Object?, Object?>? map = value.toMapOrNull<Object?, Object?>();

      if (mapToDateTime != null && map != null) return mapToDateTime(map);

      // default get the value with key or replace keys or first date time value from the map.
      return map?.getDateTimeOrNull(key, replaceKeys: replaceKeys) ??
          map?.values
              .toList()
              // sort the list by type
              .sorted((a, b) => _compareType(a, b, [DateTime, String, num]))
              // default get first date time value from the list
              .fold<DateTime?>(null, (previousValue, element) => previousValue ?? element?.toDateTimeOrNull());
    }

    if (value is! DateTime && objectToDateTime != null && value != null) return objectToDateTime(value);

    return value?.toDateTimeOrNull();
  }

  /// Get DateTime - DateTime(year, month, day, hour, minute, second, millisecond, microsecond) value or default value.
  ///
  /// [key] is the key to get the value from the map.
  ///
  /// [parentKeys] is the list of keys to get the value from the nested map.
  ///
  /// [replaceKeys] is the list of keys to replace the key if the key is not found in the map.
  ///
  /// - Same level with [key].
  ///
  /// [listToDateTime] convert the value from the list/arry json to [DateTime] or null
  ///
  /// - If not set, the default value will be the first [DateTime] value from the list.
  ///
  /// [mapToDateTime] convert the value from the map/object json to [DateTime] or null.
  ///
  /// - If not set, the default value will be the [key] or [replaceKeys] or first [DateTime] value from the map.
  ///
  /// [objectToDateTime] convert the value from the object json to [DateTime] or null.
  ///
  /// - If not set, the default value will be call [toDateTimeOrNull] normal.
  ///
  /// [defaultValue] is the default value if the value is null.
  DateTime getDateTime(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
    ConvertListTo<DateTime>? listToDateTime,
    ConvertMapTo<DateTime>? mapToDateTime,
    ConvertObjectTo<DateTime>? objectToDateTime,
    required DateTime defaultValue,
  }) {
    return getDateTimeOrNull(
      key,
      parentKeys: parentKeys,
      replaceKeys: replaceKeys,
      listToDateTime: listToDateTime,
      mapToDateTime: mapToDateTime,
      objectToDateTime: objectToDateTime,
    ).validate(defaultValue: defaultValue);
  }

  /// Get Date - DateTime(year, month, day) value or null.
  ///
  /// [key] is the key to get the value from the map.
  ///
  /// [parentKeys] is the list of keys to get the value from the nested map.
  ///
  /// [replaceKeys] is the list of keys to replace the key if the key is not found in the map.
  ///
  /// - Same level with [key].
  ///
  /// [listToDateTime] convert the value from the list/arry json to [DateTime] or null
  ///
  /// - If not set, the default value will be the first [DateTime] value from the list.
  ///
  /// [mapToDateTime] convert the value from the map/object json to [DateTime] or null.
  ///
  /// - If not set, the default value will be the [key] or [replaceKeys] or first [DateTime] value from the map.
  ///
  /// [objectToDateTime] convert the value from the object json to [DateTime] or null.
  ///
  /// - If not set, the default value will be call [toDateTimeOrNull] normal.
  DateTime? getDateOrNull(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
    ConvertListTo<DateTime>? listToDateTime,
    ConvertMapTo<DateTime>? mapToDateTime,
    ConvertObjectTo<DateTime>? objectToDateTime,
  }) {
    return getDateTimeOrNull(
      key,
      parentKeys: parentKeys,
      replaceKeys: replaceKeys,
      listToDateTime: listToDateTime,
      mapToDateTime: mapToDateTime,
      objectToDateTime: objectToDateTime,
    )?.toDateOrNull();
  }

  /// Get Date - DateTime(year, month, day) value or default value
  ///
  /// [key] is the key to get the value from the map.
  ///
  /// [parentKeys] is the list of keys to get the value from the nested map.
  ///
  /// [replaceKeys] is the list of keys to replace the key if the key is not found in the map.
  ///
  /// - Same level with [key].
  ///
  /// [listToDateTime] convert the value from the list/arry json to [DateTime] or null
  ///
  /// - If not set, the default value will be the first [DateTime] value from the list.
  ///
  /// [mapToDateTime] convert the value from the map/object json to [DateTime] or null.
  ///
  /// - If not set, the default value will be the [key] or [replaceKeys] or first [DateTime] value from the map.
  ///
  /// [objectToDateTime] convert the value from the object json to [DateTime] or null.
  ///
  /// - If not set, the default value will be call [toDateTimeOrNull] normal.
  ///
  /// [defaultValue] is the default value if the value is null.
  DateTime getDate(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
    ConvertListTo<DateTime>? listToDateTime,
    ConvertMapTo<DateTime>? mapToDateTime,
    ConvertObjectTo<DateTime>? objectToDateTime,
    required DateTime defaultValue,
  }) {
    return getDateOrNull(
      key,
      parentKeys: parentKeys,
      replaceKeys: parentKeys,
      listToDateTime: listToDateTime,
      mapToDateTime: mapToDateTime,
      objectToDateTime: objectToDateTime,
    ).validate(defaultValue: defaultValue.toDate());
  }

  /// Get Time - DateTime(0, 0, 0, hour, minute, second, millisecond, microsecond) value or null.
  ///
  /// [key] is the key to get the value from the map.
  ///
  /// [parentKeys] is the list of keys to get the value from the nested map.
  ///
  /// [replaceKeys] is the list of keys to replace the key if the key is not found in the map.
  ///
  /// - Same level with [key].
  ///
  /// [listToDateTime] convert the value from the list/arry json to [DateTime] or null
  ///
  /// - If not set, the default value will be the first [DateTime] value from the list.
  ///
  /// [mapToDateTime] convert the value from the map/object json to [DateTime] or null.
  ///
  /// - If not set, the default value will be the [key] or [replaceKeys] or first [DateTime] value from the map.
  ///
  /// [objectToDateTime] convert the value from the object json to [DateTime] or null.
  ///
  /// - If not set, the default value will be call [toDateTimeOrNull] normal.
  DateTime? getTimeOrNull(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
    ConvertListTo<DateTime>? listToDateTime,
    ConvertMapTo<DateTime>? mapToDateTime,
    ConvertObjectTo<DateTime>? objectToDateTime,
    bool second = false,
    bool millisecond = false,
    bool microsecond = false,
  }) {
    return getDateTimeOrNull(
      key,
      parentKeys: parentKeys,
      replaceKeys: replaceKeys,
      listToDateTime: listToDateTime,
      mapToDateTime: mapToDateTime,
      objectToDateTime: objectToDateTime,
    )?.toTimeOrNull(
      second: second,
      millisecond: millisecond,
      microsecond: microsecond,
    );
  }

  /// Get Time - DateTime(0, 0, 0, hour, minute, second, millisecond, microsecond) value or default value.
  ///
  /// [key] is the key to get the value from the map.
  ///
  /// [parentKeys] is the list of keys to get the value from the nested map.
  ///
  /// [replaceKeys] is the list of keys to replace the key if the key is not found in the map.
  ///
  /// - Same level with [key].
  ///
  /// [listToDateTime] convert the value from the list/arry json to [DateTime] or null
  ///
  /// - If not set, the default value will be the first [DateTime] value from the list.
  ///
  /// [mapToDateTime] convert the value from the map/object json to [DateTime] or null.
  ///
  /// - If not set, the default value will be the [key] or [replaceKeys] or first [DateTime] value from the map.
  ///
  /// [objectToDateTime] convert the value from the object json to [DateTime] or null.
  ///
  /// - If not set, the default value will be call [toDateTimeOrNull] normal.
  ///
  /// [defaultValue] is the default value if the value is null.
  DateTime getTime(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
    ConvertListTo<DateTime>? listToDateTime,
    ConvertMapTo<DateTime>? mapToDateTime,
    ConvertObjectTo<DateTime>? objectToDateTime,
    required DateTime defaultValue,
    bool second = false,
    bool millisecond = false,
    bool microsecond = false,
  }) {
    return getTimeOrNull(
      key,
      parentKeys: parentKeys,
      replaceKeys: replaceKeys,
      listToDateTime: listToDateTime,
      mapToDateTime: mapToDateTime,
      objectToDateTime: objectToDateTime,
      second: second,
      millisecond: millisecond,
      microsecond: microsecond,
    ).validate(
      defaultValue: defaultValue.toTime(
        second: second,
        millisecond: millisecond,
        microsecond: microsecond,
      ),
    );
  }

  /// Get List value or null.
  List<T>? getListOrNull<T extends Object?>(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
  }) {
    if (this == null) return null;
    if (this!.isEmpty) return null;

    final Object? parentKey = parentKeys?.removeLast();

    if (parentKey != null) {
      return getMapOrNull(
        parentKey,
        parentKeys: parentKeys,
      )?.getListOrNull<T>(
        key,
        replaceKeys: replaceKeys,
      );
    }

    final Object? value = _findValue(map: this, key: key, replaceKeys: replaceKeys);

    return value?.toListOrNull<T>();
  }

  /// Get List value or default value.
  List<T> getList<T extends Object?>(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
    List<T> defaultValue = const [],
  }) {
    return getListOrNull<T>(
      key,
      parentKeys: parentKeys,
      replaceKeys: replaceKeys,
    ).validate(defaultValue: defaultValue);
  }

  /// Get Object value or null.
  ///
  /// [T] is the type of object to get.
  ///
  /// [key] is the key to get the value from the map.
  ///
  /// [parentKeys] is the list of keys to get the value from the nested map.
  ///
  /// [replaceKeys] is the list of keys to replace the key if the key is not found in the map.
  T? getObjectOrNull<T extends Object?>(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
  }) {
    if (this == null) return null;
    if (this!.isEmpty) return null;

    final Object? parentKey = parentKeys?.removeLast();

    if (parentKey != null) {
      return getMapOrNull(
        parentKey,
        parentKeys: parentKeys,
      )?.getObjectOrNull<T>(
        key,
        replaceKeys: replaceKeys,
      );
    }

    final Object? value = _findValue(map: this, key: key, replaceKeys: replaceKeys);

    return value?.toObjectOrNull<T>();
  }

  /// Get Object value or default value.
  ///
  /// [T] is the type of object to get.
  ///
  /// [key] is the key to get the value from the map.
  ///
  /// [parentKeys] is the list of keys to get the value from the nested map.
  ///
  /// [replaceKeys] is the list of keys to replace the key if the key is not found in the map.
  ///
  /// [defaultValue] is the default value if the value is null.
  T getObject<T extends Object?>(
    Object? key, {
    List<Object>? parentKeys,
    List<Object>? replaceKeys,
    required T defaultValue,
  }) {
    return getObjectOrNull<T>(
          key,
          parentKeys: parentKeys,
          replaceKeys: replaceKeys,
        ) ??
        defaultValue;
  }
}
