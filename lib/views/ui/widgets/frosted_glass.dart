import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedGlass extends StatelessWidget {
  final Widget child;
  final double blur;
  final int opacity;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;

  const FrostedGlass._({
    required this.child,
    required this.blur,
    required this.opacity,
    required this.borderRadius,
    required this.padding,
    this.width,
    this.height,
  });

  /// Circular glass for icons
  factory FrostedGlass.icon({
    required Widget icon,
    double size = 66,
    double blur = 10,
    int opacity = 15,
    EdgeInsetsGeometry padding = const EdgeInsets.all(12),
  }) {
    return FrostedGlass._(
      blur: blur,
      opacity: opacity,
      borderRadius: BorderRadius.circular(size / 2),
      width: size,
      height: size,
      padding: padding,
      child: Center(child: icon),
    );
  }

  /// Rectangular glass card
  factory FrostedGlass.card({
    required Widget child,
    double blur = 10,
    int opacity = 15,
    double borderRadius = 24,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
    double? width,
    double? height,
  }) {
    return FrostedGlass._(
      blur: blur,
      opacity: opacity,
      borderRadius: BorderRadius.circular(borderRadius),
      width: width,
      height: height,
      padding: padding,
      child: child
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(opacity),
            borderRadius: borderRadius,
            border: Border.all(
              color: Colors.white.withAlpha(35),
              width: 0.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}