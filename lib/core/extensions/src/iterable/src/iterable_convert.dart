import 'iterable_check.dart';

/// Iterable convert extension
extension IterableConvertExt<T> on Iterable<T>? {
  /// Get the first element of the list or null
  T? get firstOrNull {
    if (isEmptyOrNull) return null;

    return this!.first;
  }

  /// Get the first element of the list or a default value
  T firstOr(T value) {
    return firstOrNull ?? value;
  }

  /// Get the last element of the list or null
  T? get lastOrNull {
    if (isEmptyOrNull) return null;

    return this!.last;
  }

  /// Get the last element of the list or a default value
  T lastOr(T value) {
    return lastOrNull ?? value;
  }

  /// Get the element at the specified index or null
  T? elementAtOrNull(int index) {
    if (isEmptyOrNull) return null;

    return this!.skip(index).firstOrNull;
  }

  /// Get the first element that satisfies the condition or null
  T? firstWhereOrNull(bool Function(T value) where) {
    if (isEmptyOrNull) return null;

    for (final element in this!) {
      if (where(element)) return element;
    }

    return null;
  }

  /// Get the last element that satisfies the condition or null
  T? lastWhereOrNull(bool Function(T value) where) {
    if (isEmptyOrNull) return null;

    T? result;
    for (final element in this!) {
      if (where(element)) result = element;
    }
    return result;
  }

  /// Get the first element whose value and index satisfies the condition or null
  T? firstWhereIndexedOrNull(bool Function(int index, T value) where) {
    if (isEmptyOrNull) return null;

    var index = 0;
    for (final element in this!) {
      if (where(index++, element)) return element;
    }
    return null;
  }

  /// Get the last element whose value and index satisfies the condition or null
  T? lastWhereIndexedOrNull(bool Function(int index, T value) where) {
    if (isEmptyOrNull) return null;

    T? result;
    var index = 0;
    for (final element in this!) {
      if (where(index++, element)) result = element;
    }
    return result;
  }
}

/// List convert extension
extension ListConvertExt<T> on List<T>? {
  /// Remove the first element of the list
  T? removeFirst() {
    if (isEmptyOrNull) return null;

    return this!.removeAt(0);
  }

  /// Remove the last element of the list
  T? removeLast() {
    if (isEmptyOrNull) return null;

    return this!.removeLast();
  }

  /// Remove the element at the specified index
  T? removeAt(int index) {
    if (isEmptyOrNull) return null;

    if (index < 0 || index >= this!.length) return null;

    return this!.removeAt(index);
  }
}

/// Set convert extension
extension SetConvertExt<T> on Set<T>? {
  /// Remove the first element of the set
  T? removeFirst() {
    if (isEmptyOrNull) return null;

    final first = this!.first;
    this!.remove(first);

    return first;
  }

  /// Remove the last element of the set
  T? removeLast() {
    if (isEmptyOrNull) return null;

    final last = this!.last;
    this!.remove(last);

    return last;
  }

  /// Remove the element at the specified index
  T? removeAt(int index) {
    if (isEmptyOrNull) return null;

    if (index < 0 || index >= this!.length) return null;

    final element = this!.elementAt(index);
    this!.remove(element);

    return element;
  }
}
