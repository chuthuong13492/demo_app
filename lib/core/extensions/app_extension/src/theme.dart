part of '../app_extension.dart';

// ignore: library_private_types_in_public_api
extension ThemeExt on _AppExt {
  ThemeData get theme => Theme.of(context);

  ColorScheme get colorScheme => theme.colorScheme;
}
