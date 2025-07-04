/// Boolean format extension methods.
extension BooleanFormatExt on bool? {
  /// Validates boolean value or returns default value.
  bool validate({
    bool defaultValue = false,
  }) {
    return this ?? defaultValue;
  }
}
