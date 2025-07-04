/// Extensions for formatting the map.
extension MapFormatExt<K, V> on Map<K, V>? {
  /// Validates the map and returns the default value if the map is null or empty.
  Map<K, V> validate({
    Map<K, V> defaultValue = const {},
  }) {
    if (this == null) return defaultValue;
    if (this!.isEmpty) return defaultValue;

    return this!;
  }
}
