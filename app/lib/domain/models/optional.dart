/// Common optional type.
class Optional<T> {
  const Optional._(this.value);

  /// Creates an empty optional.
  const Optional.empty() : this._(null);

  /// The wrapped value.
  final T? value;

  /// Returns the wrapped value or the [defaultValue] if
  /// the wrapped value is null.
  static T? resolve<T>(Optional<T?>? option, T? defaultValue) {
    if (option == null) {
      return defaultValue;
    }

    return option.value;
  }

  @override
  String toString() {
    return 'Optional($value)';
  }
}

/// Extension methods for [Optional].
extension OptionalExtention<T> on T {
  /// Returns this wrapped into an [Optional].
  Optional<T> get toOptional => Optional<T>._(this);
}
