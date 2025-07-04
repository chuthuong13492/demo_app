import 'package:demo_app/core/widgets/image/base_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AppImage extends BaseImage {
  const AppImage({
    super.key,
    required super.image,
    super.fit,
    super.height,
    super.width,
    super.errorBuilder,
    super.loadingBuilder,
    this.processIndicatorBuilder,
    super.color,
    super.clipBehavior,
    super.decoration,
    super.margin,
    super.padding,
    super.headers,
  });

  @override
  BaseImageState createState() => _AppImageState();

  final Widget Function(
    BuildContext context, {
    required int? current,
    required int? total,
  })? processIndicatorBuilder;
}

class _AppImageState extends BaseImageState {
  @override
  AppImage get widget => super.widget as AppImage;

  @override
  Object? transformImage(Object? image) {
    return super.transformImage(image);
  }

  @override
  Widget loadingBuilder(BuildContext context, {Widget? child}) {
    return widget.loadingBuilder?.call(context, child: child) ??
        Container(
          color: const Color(0xFFF5F5F5),
          width: widget.width,
          height: widget.height,
          alignment: Alignment.center,
          child: child,
        );
  }

  @override
  Widget progressIndicatorBuilder(
    BuildContext context, {
    required int? current,
    required int? total,
  }) {
    if (widget.processIndicatorBuilder != null) {
      return widget.processIndicatorBuilder!.call(
        context,
        current: current,
        total: total,
      );
    }

    final double? progress = (current != null && total != null) ? (current / total).clamp(0.0, 1.0) : null;

    return loadingBuilder(
      context,
      child: progress != null
          ? _DownloadIndicator(
              current: current,
              total: total,
            )
          : null,
    );
  }
}

class _DownloadIndicator extends StatelessWidget {
  const _DownloadIndicator({
    required this.current,
    required this.total,
  });

  final int? current;

  final int? total;

  @override
  Widget build(BuildContext context) {
    if (total == 0) return const SizedBox.shrink();

    final double? progress = (current != null && total != null) ? (current! / total!).clamp(0.0, 1.0) : null;

    return progress != null
        ? Center(
            child: CircularPercentIndicator(
              radius: 30,
              percent: progress,
              progressColor: Theme.of(context).colorScheme.primary,
              animation: true,
              animateToInitialPercent: true,
              animateFromLastPercent: true,
              center:
                  // icon f0ed lệch phải
                  Transform.translate(
                offset: const Offset(-4, 0),
                child: Icon(
                  Icons.circle_outlined,
                  size: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
