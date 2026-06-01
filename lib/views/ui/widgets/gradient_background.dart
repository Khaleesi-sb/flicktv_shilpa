import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // ── Gradient base ──────────────────────────────────────────────
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF2F2608), // 0%
                Color(0xFF2B2207), // 8%
                Color(0xFF271F07), // 17%
                Color(0xFF231B06), // 25%
                Color(0xFF1F1805), // 33%
                Color(0xFF1A1404), // 42%
                Color(0xFF161104), // 50%
                Color(0xFF120D03), // 58%
                Color(0xFF0E0A02), // 67%
                Color(0xFF090702), // 75%
                Color(0xFF060401), // 83%
                Color(0xFF020100), // 92%
                Color(0xFF000000), // 100%
              ],
              stops: [
                0.0, 0.08, 0.17, 0.25, 0.33,
                0.42, 0.50, 0.58, 0.67, 0.75,
                0.83, 0.92, 1.0,
              ],
            ),
          ),
        ),

        // ── Dot grid overlay (top 150px) ───────────────────────────────
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: MediaQuery.of(context).size.height * 0.15,
          child: CustomPaint(
            painter: _DotGridPainter(),
          ),
        ),

        // ── Caller's content ───────────────────────────────────────────
        child,
      ],
    );
  }
}

class _DotGridPainter extends CustomPainter {
  const _DotGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const dotSize = 4.0;
    const spacing = 14.0;
    const baseColor = Color(0xFF705616);

    final paint = Paint()..style = PaintingStyle.fill;

    final cols = (size.width / spacing).ceil();
    final rows = (size.height / spacing).ceil();

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        final x = col * spacing + spacing / 2;
        final y = row * spacing + spacing / 2;
        final fade = 1.0 - (y / size.height);

        canvas.drawRect(
          Rect.fromCenter(
            center: Offset(x, y),
            width: dotSize,
            height: dotSize,
          ),
          paint..color = baseColor.withOpacity(fade.clamp(0.0, 1.0)),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}