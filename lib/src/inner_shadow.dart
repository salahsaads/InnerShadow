import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A widget that renders an inner shadow effect on its child.
///
/// Wraps any widget and paints an inset shadow using [blur], [color],
/// and [offset] parameters.
///
/// Example:
/// ```dart
/// InnerShadow(
///   blur: 10,
///   color: Colors.black38,
///   offset: Offset(10, 10),
///   child: Container(
///     width: 200,
///     height: 200,
///     decoration: BoxDecoration(
///       color: Colors.white,
///       borderRadius: BorderRadius.circular(16),
///     ),
///   ),
/// )
/// ```
///
/// Based on: https://stackoverflow.com/a/60530625
/// Original author: Alexandr Priezzhev, licensed under CC BY-SA 4.0.
class InnerShadow extends SingleChildRenderObjectWidget {
  const InnerShadow({
    super.key,
    this.blur = 10,
    this.color = Colors.black38,
    this.offset = const Offset(10, 10),
    super.child,
  });

  /// The blur radius of the shadow. Higher values produce a softer shadow.
  final double blur;

  /// The color of the shadow.
  final Color color;

  /// The offset of the shadow relative to the widget's origin.
  final Offset offset;

  @override
  RenderObject createRenderObject(BuildContext context) {
    final renderObject = _RenderInnerShadow();
    updateRenderObject(context, renderObject);
    return renderObject;
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderInnerShadow renderObject,
  ) {
    renderObject
      ..color = color
      ..blur = blur
      ..dx = offset.dx
      ..dy = offset.dy;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('blur', blur))
      ..add(ColorProperty('color', color))
      ..add(DiagnosticsProperty<Offset>('offset', offset));
  }
}

class _RenderInnerShadow extends RenderProxyBox {
  double _blur = 10;
  Color _color = Colors.black38;
  double _dx = 10;
  double _dy = 10;

  double get blur => _blur;
  set blur(double value) {
    if (_blur == value) return;
    _blur = value;
    markNeedsPaint();
  }

  Color get color => _color;
  set color(Color value) {
    if (_color == value) return;
    _color = value;
    markNeedsPaint();
  }

  double get dx => _dx;
  set dx(double value) {
    if (_dx == value) return;
    _dx = value;
    markNeedsPaint();
  }

  double get dy => _dy;
  set dy(double value) {
    if (_dy == value) return;
    _dy = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;

    final rectOuter = offset & size;
    final rectInner = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      size.width - _dx,
      size.height - _dy,
    );

    final canvas = context.canvas..saveLayer(rectOuter, Paint());
    context.paintChild(child!, offset);

    final shadowPaint = Paint()
      ..blendMode = BlendMode.srcATop
      ..imageFilter = ImageFilter.blur(sigmaX: _blur, sigmaY: _blur)
      ..colorFilter = ColorFilter.mode(_color, BlendMode.srcOut);

    canvas
      ..saveLayer(rectOuter, shadowPaint)
      ..saveLayer(rectInner, Paint())
      ..translate(_dx, _dy);

    context.paintChild(child!, offset);

    canvas
      ..restore()
      ..restore()
      ..restore();
  }
}
