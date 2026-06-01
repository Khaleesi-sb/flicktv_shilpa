import 'dart:math';

import 'package:flutter/material.dart';

import 'confetti_painter.dart';
import 'shape_type.dart';

class ConfettiAnimation extends StatefulWidget {
  const ConfettiAnimation({super.key});

  @override
  State<ConfettiAnimation> createState() => _ConfettiAnimationState();
}

class _ConfettiAnimationState extends State<ConfettiAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Offset> _positions;
  late List<Color> _colors; // Colors for each particle
  late List<double> _velocitiesX; // Horizontal velocities
  late List<double> _velocitiesY; // Vertical velocities
  late List<ShapeType> _shapes; // Shape types for each particle

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )
      ..addListener(() {
        setState(() {
          _updatePositions();
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Clear confetti when animation completes
          _positions.clear();
          _velocitiesX.clear();
          _velocitiesY.clear();
          _shapes.clear();
          setState(() {});
        }
      });

    _positions = List.generate(0, (index) => Offset.zero);
    _colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
    ];
    _shapes = List.generate(0, (index) => ShapeType.circle);

    // Fire confetti as soon as the first frame is laid out
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 700));
      if (mounted) {
        startAnimation();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startAnimation() {
    final random = Random();
    const count = 14; // 7 per side

    // Left side burst — fires right and upward
    final leftPositions = List.generate(
      count ~/ 2,
          (_) => Offset(0, MediaQuery.sizeOf(context).height / 2),
    );
    final leftVX = List.generate(count ~/ 2, (_) => 4 + random.nextDouble() * 8);
    final leftVY = List.generate(count ~/ 2, (_) => -random.nextDouble() * 16);

    // Right side burst — fires left and upward
    final rightPositions = List.generate(
      count ~/ 2,
          (_) => Offset(MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).height / 2),
    );
    final rightVX = List.generate(count ~/ 2, (_) => -(4 + random.nextDouble() * 8));
    final rightVY = List.generate(count ~/ 2, (_) => -random.nextDouble() * 16);

    _positions = [...leftPositions, ...rightPositions];
    _velocitiesX = [...leftVX, ...rightVX];
    _velocitiesY = [...leftVY, ...rightVY];
    _shapes = List.generate(
      count,
          (_) => ShapeType.values[random.nextInt(ShapeType.values.length)],
    );

    _controller.reset();
    _controller.forward();
  }

  void _updatePositions() {
    final random = Random();
    for (int i = 0; i < _positions.length; i++) {
      _positions[i] = Offset(
        _positions[i].dx + _velocitiesX[i],
        _positions[i].dy + _velocitiesY[i],
      );

      // Apply gravity to the vertical velocity
      _velocitiesY[i] += 0.3; // Reduced gravity for slower fall

      // Add some randomness to the horizontal velocity for a more natural effect
      _velocitiesX[i] += (random.nextDouble() - 0.5) * 0.2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: ConfettiPainter(
        positions: _positions,
        colors: _colors,
        shapes: _shapes,
      ),
    );
  }
}