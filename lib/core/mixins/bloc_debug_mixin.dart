import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin BlocDebugMixin<T> on BlocBase<T> {
  @protected
  List<Object?>? get blocDebugIdentity {
    final Object? state = this.state;
    if (state is Equatable) {
      final List<Object?> props = state.props;

      final Object? id = props.firstOrNull;

      if (id is num || id is String || id is DateTime || id is bool) {
        return [id];
      }
    }

    return null;
  }

  String toDebug() {
    final List<Object?>? id = blocDebugIdentity;

    if (id != null && id.isNotEmpty) {
      return '$runtimeType(${id.map((prop) => prop.toString()).join(', ')})';
    }

    return '$runtimeType';
  }
}
