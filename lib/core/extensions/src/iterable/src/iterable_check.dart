/// Iterable check extension
extension IterableCheckExt<T> on Iterable<T>? {
  /// Check if the list is null or empty.
  bool get isEmptyOrNull {
    if (this == null) return true;

    return this!.isEmpty;
  }

  /// Check if the list is not null and not empty.
  bool get isNotEmptyAndNull => !isEmptyOrNull;

  /// Whether no element satisfies [test].
  ///
  /// Returns true if no element satisfies [test],
  /// and false if at least one does.
  ///
  /// Equivalent to `iterable.every((x) => !test(x))` or
  /// `!iterable.any(test)`.
  bool none(bool Function(T) test) {
    if (isEmptyOrNull) return true;

    for (final element in this!) {
      if (test(element)) return false;
    }
    return true;
  }
}
