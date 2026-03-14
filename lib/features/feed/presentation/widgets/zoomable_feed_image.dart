import 'package:flutter/material.dart';

import '../../../../shared/design/app_durations.dart';
import '../../../../shared/presentation/widgets/app_async_image.dart';

class ZoomableFeedImage extends StatefulWidget {
  const ZoomableFeedImage({
    required this.imageUrl,
    required this.onZoomStateChanged,
    super.key,
  });

  final String imageUrl;
  final ValueChanged<bool> onZoomStateChanged;

  @override
  State<ZoomableFeedImage> createState() => _ZoomableFeedImageState();
}

class _ZoomableFeedImageState extends State<ZoomableFeedImage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _imageKey = GlobalKey();

  OverlayEntry? _overlayEntry;
  late final AnimationController _returnController;

  Animation<double>? _scaleAnimation;
  Animation<Offset>? _offsetAnimation;

  Rect? _originRect;
  Offset _baseFocalPoint = Offset.zero;
  Offset _translation = Offset.zero;
  double _scale = 1;
  bool _isZooming = false;

  @override
  void initState() {
    super.initState();
    _returnController =
        AnimationController(
            vsync: this,
            duration: AppDurations.zoomReturn,
          )
          ..addListener(_handleAnimationTick)
          ..addStatusListener(_handleAnimationStatus);
  }

  @override
  void dispose() {
    if (_isZooming) {
      widget.onZoomStateChanged(false);
    }
    _removeOverlay();
    _returnController.dispose();
    super.dispose();
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseFocalPoint = details.focalPoint;
    _originRect = _measureRect();
    _returnController.stop();
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    if (!_isZooming && details.scale <= 1.02 && details.pointerCount < 2) {
      return;
    }

    _ensureOverlay();
    _scale = details.scale.clamp(1.0, 3.0);
    _translation = details.focalPoint - _baseFocalPoint;
    _overlayEntry?.markNeedsBuild();
    if (mounted) {
      setState(() {});
    }
  }

  void _handleScaleEnd(ScaleEndDetails details) {
    if (!_isZooming) {
      return;
    }

    _scaleAnimation = Tween<double>(begin: _scale, end: 1).animate(
      CurvedAnimation(parent: _returnController, curve: Curves.easeOutCubic),
    );
    _offsetAnimation = Tween<Offset>(begin: _translation, end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _returnController,
            curve: Curves.easeOutCubic,
          ),
        );
    _returnController
      ..reset()
      ..forward();
  }

  void _handleAnimationTick() {
    if (_scaleAnimation == null || _offsetAnimation == null) {
      return;
    }

    _scale = _scaleAnimation!.value;
    _translation = _offsetAnimation!.value;
    _overlayEntry?.markNeedsBuild();
    if (mounted) {
      setState(() {});
    }
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed) {
      return;
    }

    _scale = 1;
    _translation = Offset.zero;
    _removeOverlay();
    if (_isZooming) {
      widget.onZoomStateChanged(false);
    }
    if (mounted) {
      setState(() {
        _isZooming = false;
      });
    }
  }

  void _ensureOverlay() {
    if (_isZooming || _originRect == null) {
      return;
    }

    _overlayEntry = OverlayEntry(builder: _buildOverlay);
    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
    _isZooming = true;
    widget.onZoomStateChanged(true);
    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildOverlay(BuildContext context) {
    final rect = _originRect;
    if (rect == null) {
      return const SizedBox.shrink();
    }

    final overlayScale = _scale.clamp(1.0, 3.0);
    final barrierOpacity = ((overlayScale - 1) / 2.0)
        .clamp(0.0, 0.5)
        .toDouble();

    return IgnorePointer(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: Colors.black.withValues(alpha: barrierOpacity)),
            Positioned(
              left: rect.left,
              top: rect.top,
              width: rect.width,
              height: rect.height,
              child: Transform.translate(
                offset: _translation,
                child: Transform.scale(
                  scale: overlayScale,
                  alignment: Alignment.center,
                  child: _buildImage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Rect? _measureRect() {
    final context = _imageKey.currentContext;
    if (context == null) {
      return null;
    }

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) {
      return null;
    }

    final offset = renderBox.localToGlobal(Offset.zero);
    return offset & renderBox.size;
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Widget _buildImage() {
    return RepaintBoundary(
      child: AppAsyncImage(
        imageUrl: widget.imageUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _imageKey,
      onScaleStart: _handleScaleStart,
      onScaleUpdate: _handleScaleUpdate,
      onScaleEnd: _handleScaleEnd,
      behavior: HitTestBehavior.opaque,
      child: Opacity(opacity: _isZooming ? 0 : 1, child: _buildImage()),
    );
  }
}
