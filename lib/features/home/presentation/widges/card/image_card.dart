import 'package:demo_app/core/widgets/image/app_image.dart';
import 'package:demo_app/routes/route.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          DetailRoute(url).push(context);
        },
        child: AppImage(
          image: url,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
