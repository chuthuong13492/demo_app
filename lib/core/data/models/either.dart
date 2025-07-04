/// A type that represents one of two possible types (a disjoint union).
abstract interface class Either<L, R> {
  const Either();

  /// Returns the result of applying [ifLeft] if this is a [Left] or [ifRight] if this is a [Right].
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight);

  /// Returns `true` if this is a [Left], `false` otherwise.
  bool get isLeft => fold((_) => true, (_) => false);

  /// Returns `true` if this is a [Right], `false` otherwise.
  bool get isRight => fold((_) => false, (_) => true);

  /// Returns the value from this [Left] or `null` if this is a [Right].
  L? get leftOrNull => fold((l) => l, (_) => null);

  /// Returns the value from this [Right] or `null` if this is a [Left].
  R? get rightOrNull => fold((_) => null, (r) => r);

  /// Maps the value from this [Left] to a new value.
  B? foldLeft<B>(B Function(L l) ifLeft) => fold(ifLeft, (_) => null);

  /// Maps the value from this [Right] to a new value.
  B? foldRight<B>(B Function(R r) ifRight) => fold((_) => null, ifRight);
}

/// Represents the left side of [Either] class which by convention is a "failure".
class Left<L, R> extends Either<L, R> {
  /// Constructs a left instance.
  const Left(this._l);

  final L _l;

  /// The value of this side of [Either].
  L get value => _l;

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifLeft(_l);

  @override
  bool operator ==(Object other) => other is Left && other._l == _l;

  @override
  int get hashCode => _l.hashCode;
}

/// Represents the right side of [Either] class which by convention is a "success".
class Right<L, R> extends Either<L, R> {
  /// Constructs a right instance.
  const Right(this._r);

  final R _r;

  /// The value of this side of [Either].
  R get value => _r;

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifRight(_r);

  @override
  bool operator ==(Object other) => other is Right && other._r == _r;

  @override
  int get hashCode => _r.hashCode;
}
