// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:developer';

import 'package:demo_app/core/router/app_router.dart';
import 'package:demo_app/core/utilities/loading_overlay.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:go_router/go_router.dart';
import 'package:talker/talker.dart';

part 'src/debug.dart';
part 'src/navigation.dart';
part 'src/theme.dart';
part 'src/overlay.dart';

class _AppExt {
  const _AppExt();
}

// ignore: constant_identifier_names
const App = _AppExt();

final Completer<void> startAppCompleter = Completer<void>();

extension AppExt on _AppExt {
  Future<void> waitStartAppFinish() {
    return startAppCompleter.future;
  }
}

extension FocusExt on _AppExt {
  FocusNode? get focusScope => FocusManager.instance.primaryFocus;

  void unfocus() {
    focusScope?.unfocus();
  }
}
