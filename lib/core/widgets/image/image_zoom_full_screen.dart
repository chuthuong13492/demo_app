import 'package:flutter/material.dart';

/// A widget that displays an image in fullscreen.
class ImageZoomFullscreen extends StatefulWidget {
  /// Constructor for creating an ImageZoomFullscreen widget.
  const ImageZoomFullscreen({
    super.key,
    required this.zoomWidget,
    required this.minScale,
    required this.maxScale,
    required this.heroAnimationTag,
    this.fullScreenDoubleTapZoomScale,
  });

  /// The widget to display in fullscreen.
  final Widget zoomWidget;

  /// The minimum scale of the image.
  final double minScale;

  /// The maximum scale of the image.
  final double maxScale;

  /// The hero animation tag.
  final Object heroAnimationTag;

  /// The scale to zoom in when double tapping.
  final double? fullScreenDoubleTapZoomScale;

  @override
  State<ImageZoomFullscreen> createState() => ImageZoomFullscreenState();
}

/// The state of the [ImageZoomFullscreen] widget.
class ImageZoomFullscreenState extends State<ImageZoomFullscreen> with SingleTickerProviderStateMixin {
  /// The transformation controller for the image.
  @protected
  final TransformationController transformationController = TransformationController();

  /// The animation controller for the image.
  @protected
  late AnimationController animationController;

  /// The closing treshold for the image.
  @protected
  late double closingTreshold = MediaQuery.of(context).size.height * 0.1;

  /// The animation for the image.
  @protected
  Animation<Matrix4>? animation;

  /// The opacity of the image.
  @protected
  double opacity = 1;

  /// The position of the image.
  @protected
  double imagePosition = 0;

  /// The duration of the animation.
  @protected
  Duration animationDuration = Duration.zero;

  /// The duration of the opacity.
  @protected
  Duration opacityDuration = Duration.zero;

  /// The current scale of the image.
  @protected
  late double currentScale = widget.minScale;

  /// The details of the double tap.
  @protected
  TapDownDetails? doubleTapDownDetails;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() => transformationController.value = animation!.value);
  }

  @override
  void dispose() {
    transformationController.dispose();
    animationController.dispose();
    super.dispose();
  }

  /// Zooms in or out the image.
  @protected
  void zoomInOut() {
    final Offset tapPosition = doubleTapDownDetails!.localPosition;
    final double zoomScale = widget.fullScreenDoubleTapZoomScale ?? widget.maxScale;

    final double x = -tapPosition.dx * (zoomScale - 1);
    final double y = -tapPosition.dy * (zoomScale - 1);

    final Matrix4 zoomedMatrix = Matrix4.identity()
      ..translate(x, y)
      ..scale(zoomScale);

    final Matrix4 widgetMatrix = transformationController.value.isIdentity() ? zoomedMatrix : Matrix4.identity();

    animation = Matrix4Tween(
      begin: transformationController.value,
      end: widgetMatrix,
    ).animate(
      CurveTween(curve: Curves.easeOut).animate(animationController),
    );

    animationController.forward(from: 0);
    currentScale = transformationController.value.isIdentity() ? zoomScale : widget.minScale;
  }

  /// Called when the interaction starts.
  @protected
  void onInteractionStart(ScaleStartDetails details) {
    animationDuration = Duration.zero;
    opacityDuration = Duration.zero;
  }

  /// Called when the interaction ends.
  @protected
  void onInteractionEnd(ScaleEndDetails details) async {
    currentScale = transformationController.value.getMaxScaleOnAxis();
    animationDuration = const Duration(milliseconds: 300);
    if (mounted) {
      setState(() {});
    }

    if (imagePosition > closingTreshold) {
      imagePosition = MediaQuery.of(context).size.height; // move image down
      if (mounted) {
        setState(() {});
      }
      Navigator.of(context).pop();
    } else {
      imagePosition = 0;
      opacity = 1;
      opacityDuration = const Duration(milliseconds: 300);
      if (mounted) {
        setState(() {});
      }
    }
  }

  /// Called when the interaction updates.
  @protected
  void onInteractionUpdate(ScaleUpdateDetails details) {
    // chose 1.05 because maybe the image was not fully zoomed back but it almost looks like that
    if (details.pointerCount == 1 && currentScale <= 1.05) {
      setState(() {
        imagePosition += details.focalPointDelta.dy;
        opacity = (1 - (imagePosition / closingTreshold)).clamp(0, 1).toDouble();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundBuilder(context),
        imageBuilder(context),
        closeBuilder(context),
      ],
    );
  }

  /// Builds the image.
  @protected
  Widget imageBuilder(BuildContext context) {
    return AnimatedPositioned(
      duration: animationDuration,
      top: imagePosition,
      bottom: -imagePosition,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: InteractiveViewer(
          constrained: true,
          transformationController: transformationController,
          minScale: widget.minScale,
          maxScale: widget.maxScale,
          onInteractionStart: onInteractionStart,
          onInteractionUpdate: onInteractionUpdate,
          onInteractionEnd: onInteractionEnd,
          child: GestureDetector(
            // need to have both methods, otherwise the zoom will be triggered before the second tap releases the screen
            onDoubleTapDown: (details) {
              doubleTapDownDetails = details;
            },
            onDoubleTap: zoomInOut,
            child: Hero(
              tag: widget.heroAnimationTag,
              child: widget.zoomWidget,
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the background.
  @protected
  Widget backgroundBuilder(BuildContext context) {
    return Positioned.fill(
      child: AnimatedOpacity(
        duration: opacityDuration,
        opacity: opacity,
        child: Container(
          color: Colors.black,
        ),
      ),
    );
  }

  /// Builds the close button.
  @protected
  Widget closeBuilder(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.of(context).pop();
          },
          child: AnimatedOpacity(
            duration: opacityDuration,
            opacity: opacity,
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
