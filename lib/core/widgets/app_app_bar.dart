import 'package:flutter/material.dart';

import 'app_back_button.dart';

class AppAppBar extends AppBar {
  AppAppBar({
    super.key,
    bool centerTitle = true,
    required String title,
    super.titleTextStyle,
    super.actions,
    super.backgroundColor,
    Widget? leading,
    super.automaticallyImplyLeading,
    super.leadingWidth,
    super.bottom,
    super.scrolledUnderElevation,
  }) : super(
          title: Text(
            title,
            textAlign: centerTitle ? TextAlign.center : TextAlign.start,
            style: titleTextStyle,
          ),
          leading: leading ?? const AppBackButton(),
          centerTitle: centerTitle,
        );
}
