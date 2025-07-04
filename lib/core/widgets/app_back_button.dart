import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.color,
    this.canPop,
    this.onPressed,
  });

  final Color? color;

  final VoidCallback? onPressed;

  final bool? canPop;

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);

    final bool check = canPop ?? parentRoute?.canPop ?? false;

    if (!check) {
      return const SizedBox.shrink();
    }

    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      color: color,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Navigator.maybePop(context);
        }
      },
    );
  }
}
