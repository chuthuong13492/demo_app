import 'package:demo_app/core/widgets/image/app_image.dart';
import 'package:demo_app/core/widgets/image/image_zoom.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ImageZoom(
      heroAnimationTag: url,
      image: AppImage(
        image: url,
        fit: BoxFit.contain,
      ),
    );
  }
}
