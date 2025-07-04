/// Map check extension.
extension MapCheckExt<K, V> on Map<K, V>? {
  /// Check if map is empty or null.
  bool get isEmptyOrNull {
    if (this == null) return true;
    if (this!.isEmpty) return true;

    return false;
  }

  /// Check if map is not empty or null.
  bool get isNotEmptyOrNull => !isEmptyOrNull;

  /// Check if map contains all keys.
  bool containsAllKeys(Iterable<K> keys) {
    if (this == null) return false;
    if (this!.isEmpty) return false;

    for (final key in keys) {
      if (!this!.containsKey(key)) {
        return false;
      }
    }

    return true;
  }

  /// Check if map contains all values.
  bool containsAllValues(Iterable<V> values) {
    if (this == null) return false;
    if (this!.isEmpty) return false;

    for (final value in values) {
      if (!this!.containsValue(value)) {
        return false;
      }
    }
    return true;
  }

  /// Check if map contains any key.
  bool containsAnyKey(Iterable<K> keys) {
    if (this == null) return false;
    if (this!.isEmpty) return false;

    for (final key in keys) {
      if (this!.containsKey(key)) {
        return true;
      }
    }
    return false;
  }

  /// Check if map contains any value.
  bool containsAnyValue(Iterable<V> values) {
    if (this == null) return false;
    if (this!.isEmpty) return false;

    for (final value in values) {
      if (this!.containsValue(value)) {
        return true;
      }
    }
    return false;
  }
}
