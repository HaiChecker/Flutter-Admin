import 'package:flutter_admin/widgets/button/style.dart';

typedef AdminButtonPropertyResolver<T> = T Function(
    Set<AdminButtonType> states);

abstract class AdminButtonStateProperty<T> {
  T resolve(Set<AdminButtonType> states);

  T resolveOne(AdminButtonType state);

  static T resolveAs<T>(T value, Set<AdminButtonType> states) {
    if (value is AdminButtonStateProperty<T>) {
      final AdminButtonStateProperty<T> property = value;
      return property.resolve(states);
    }
    return value;
  }

  static AdminButtonStateProperty<T> resolveWith<T>(
          AdminButtonPropertyResolver<T> callback) =>
      _AdminButtonTypePropertyWith<T>(callback);

  static AdminButtonStateProperty<T?>? lerp<T>(
    AdminButtonStateProperty<T>? a,
    AdminButtonStateProperty<T>? b,
    double t,
    T? Function(T?, T?, double) lerpFunction,
  ) {
    // Avoid creating a _LerpProperties object for a common case.
    if (a == null && b == null) {
      return null;
    }
    return _LerpProperties<T>(a, b, t, lerpFunction);
  }
}

class _LerpProperties<T> implements AdminButtonStateProperty<T?> {
  const _LerpProperties(this.a, this.b, this.t, this.lerpFunction);

  final AdminButtonStateProperty<T>? a;
  final AdminButtonStateProperty<T>? b;
  final double t;
  final T? Function(T?, T?, double) lerpFunction;

  @override
  T? resolve(Set<AdminButtonType> states) {
    final T? resolvedA = a?.resolve(states);
    final T? resolvedB = b?.resolve(states);
    return lerpFunction(resolvedA, resolvedB, t);
  }

  @override
  T? resolveOne(AdminButtonType state) {
    var states = [state];
    return resolve(states.toSet());
  }
}

class _AdminButtonTypePropertyWith<T> implements AdminButtonStateProperty<T> {
  final AdminButtonPropertyResolver<T> _resolve;

  _AdminButtonTypePropertyWith(this._resolve);

  @override
  T resolve(Set<AdminButtonType> states) => _resolve(states);

  @override
  T resolveOne(AdminButtonType state) {
    var states = [state];
    return _resolve(states.toSet());
  }
}
