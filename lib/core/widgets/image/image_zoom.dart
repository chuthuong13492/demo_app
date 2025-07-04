import 'package:flutter/material.dart';

import 'image_zoom_full_screen.dart';

/// A widget that displays an image that can be zoomed in.
class ImageZoom extends StatefulWidget {
  /// Constructor for creating an ImageZoom widget.
  const ImageZoom({
    super.key,
    this.minScaleEmbeddedView = 1,
    this.maxScaleEmbeddedView = 4,
    this.minScaleFullscreen = 1,
    this.maxScaleFullscreen = 4,
    this.fullScreenDoubleTapZoomScale,
    required this.heroAnimationTag,
    required this.image,
  });

  /// The image that should be zoomed.
  final Widget image;

  /// The minimal scale that is allowed for this widget to be zoomed to.
  final double minScaleEmbeddedView;

  /// The maximal scale that is allowed for this widget to be zoomed to.
  final double maxScaleEmbeddedView;

  /// min scale for the widget in fullscreen
  final double minScaleFullscreen;

  /// max scale for the widget in fullscreen
  final double maxScaleFullscreen;

  /// if not specified the [maxScaleFullscreen] is used
  final double? fullScreenDoubleTapZoomScale;

  /// provide custom hero animation tag and make sure every [ImageZoom] in your subtree uses a different tag. otherwise the animation doesnt work
  final Object heroAnimationTag;

  @override
  State<ImageZoom> createState() => ImageZoomState();
}

/// The state of the [ImageZoom] widget.
class ImageZoomState extends State<ImageZoom> with SingleTickerProviderStateMixin {
  /// The transformation controller for the image.
  @protected
  final TransformationController transformationController = TransformationController();

  /// The animation controller for the image.
  @protected
  late AnimationController animationController;

  /// The scale of the image.
  @protected
  late double scale = widget.minScaleEmbeddedView;

  /// The animation for the image.
  @protected
  Animation<Matrix4>? animation;

  /// The overlay entry for the image.
  @protected
  OverlayEntry? entry;

  /// The duration of the opacity background.
  @protected
  Duration opcaityBackgroundDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )
      ..addListener(() => transformationController.value = animation!.value)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          removeOverlay();
        }
      });
  }

  @override
  void dispose() {
    transformationController.dispose();
    animationController.dispose();
    removeOverlay();
    super.dispose();
  }

  /// Removes the overlay.
  @protected
  void removeOverlay() {
    opcaityBackgroundDuration = Duration.zero;
    entry?.remove();
    entry = null;
  }

  /// Resets the animation.
  @protected
  void resetAnimation() {
    opcaityBackgroundDuration = animationController.duration ?? const Duration(milliseconds: 300);
    animation = Matrix4Tween(
      begin: transformationController.value,
      end: Matrix4.identity(),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
    animationController.forward(from: 0);
  }

  /// Opens the image in fullscreen.
  void openImageFullscreen() {
    Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation1, animation2) {
          return FadeTransition(
            opacity: animation1,
            child: imageZoomFullscreenBuilder(
              context: context,
              zoomWidget: widget.image is Image
                  ? Image(
                      image: (widget.image as Image).image,
                      fit: BoxFit.contain,
                    )
                  : widget.image,
              minScale: widget.minScaleFullscreen,
              maxScale: widget.maxScaleFullscreen,
              heroAnimationTag: widget.heroAnimationTag,
              fullScreenDoubleTapZoomScale: widget.fullScreenDoubleTapZoomScale,
            ),
          );
        },
      ),
    );
  }

  /// Updates the interaction.
  @protected
  void onInteractionUpdate(ScaleUpdateDetails details) {
    if (entry != null) {
      scale = details.scale;
      entry?.markNeedsBuild();
    }
  }

  /// Shows the overlay.
  @protected
  void showOverlay(BuildContext context, ScaleStartDetails details) {
    if (details.pointerCount > 1) {
      removeOverlay();

      final RenderObject? renderObject = context.findRenderObject();
      RenderBox? imageBox;

      if (renderObject is RenderBox) {
        imageBox = renderObject;
      }

      final Offset? imageOffset = imageBox?.localToGlobal(Offset.zero);

      entry = OverlayEntry(
        builder: (context) => Stack(
          children: [
            Positioned.fill(
              child: AnimatedOpacity(
                duration: opcaityBackgroundDuration,
                opacity: ((scale - 1) / (widget.maxScaleEmbeddedView - 1)).clamp(0, 1).toDouble(),
                child: Container(
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              left: imageOffset?.dx,
              top: imageOffset?.dy,
              width: imageBox?.size.width,
              height: imageBox?.size.height,
              child: imageBuilder(context),
            ),
          ],
        ),
      );

      final OverlayState overlay = Overlay.of(context);
      overlay.insert(entry!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: openImageFullscreen,
      child: imageBuilder(context),
    );
  }

  /// Builds the image.
  @protected
  Widget imageBuilder(BuildContext context) {
    return InteractiveViewer(
      transformationController: transformationController,
      panEnabled: false,
      clipBehavior: Clip.none,
      minScale: widget.minScaleEmbeddedView,
      maxScale: widget.maxScaleEmbeddedView,
      onInteractionStart: (details) {
        showOverlay(context, details);
      },
      onInteractionUpdate: onInteractionUpdate,
      onInteractionEnd: (details) {
        resetAnimation();
      },
      child: Hero(
        tag: widget.heroAnimationTag,
        child: widget.image,
      ),
    );
  }

  /// Builds the image in fullscreen.
  @protected
  Widget imageZoomFullscreenBuilder({
    required BuildContext context,
    required Widget zoomWidget,
    required double minScale,
    required double maxScale,
    required Object heroAnimationTag,
    required double? fullScreenDoubleTapZoomScale,
  }) {
    return ImageZoomFullscreen(
      zoomWidget: zoomWidget,
      minScale: minScale,
      maxScale: maxScale,
      heroAnimationTag: heroAnimationTag,
      fullScreenDoubleTapZoomScale: fullScreenDoubleTapZoomScale,
    );
  }
}
