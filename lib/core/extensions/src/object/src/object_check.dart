/// Object check extension
extension ObjectCheckExt on Object? {
  /// Checks if the object is null.
  bool get isNull => this == null;

  /// Checks if the object is not null.
  bool get isNotNull => !isNull;

  /// Check if the object is integer.
  bool get isInt {
    if (this == null) return false;
    if (this is double) return (this! as double).toInt() == this;
    return this is int;
  }

  /// Check if the object is double.
  bool get isDouble {
    if (this == null) return false;
    return this is double;
  }

  /// Check if the object is boolean.
  bool get isBool {
    if (this == null) return false;
    return this is bool;
  }

  /// Check if the object is string.
  bool get isString {
    if (this == null) return false;
    return this is String;
  }

  /// Check if the object is list.
  bool isList<T>() {
    if (this == null) return false;
    return this is List<T>;
  }

  /// Check if the object is map.
  bool isMap<K, V>() {
    if (this == null) return false;
    return this is Map<K, V>;
  }

  /// Check if the object is set.
  bool isSet<T>() {
    if (this == null) return false;
    return this is Set<T>;
  }

  /// Check if the object is iterable.
  bool isIterable<T>() {
    if (this == null) return false;
    return this is Iterable<T>;
  }

  /// Check if the object is datetime.
  bool get isDateTime {
    if (this == null) return false;
    return this is DateTime;
  }

  /// Check if the object is duration.
  bool get isDuration {
    if (this == null) return false;
    return this is Duration;
  }

  /// Check if the object is `<T>`.
  bool isObject<T>() {
    if (this == null && null is T) return true;
    if (this == null) return false;
    return this is T;
  }
}
