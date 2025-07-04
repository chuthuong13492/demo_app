import 'package:demo_app/core/extensions/app_extension/app_extension.dart';
import 'package:demo_app/core/widgets/image/app_image.dart';
import 'package:demo_app/features/detail/presentation/blocs/detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionWidget extends StatelessWidget {
  const ActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        spacing: 20,
        children: [
          _IconButton(
            icon: 'ic_download',
            onPressed: (context) {
              context.read<DetailBloc>().add(DownloadImageEvent());
            },
          ),
          _IconButton(
            icon: 'ic_close',
            onPressed: (context) {
              App.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
    required this.onPressed,
  });
  final String icon;
  final Function(BuildContext) onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(context),
      child: AppImage(
        image: 'assets/$icon.png',
        width: 30,
        height: 30,
        fit: BoxFit.contain,
        color: Colors.white,
      ),
    );
  }
}
