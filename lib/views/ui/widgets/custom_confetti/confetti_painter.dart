import 'package:flutter/material.dart';

import 'shape_type.dart';

class ConfettiPainter extends CustomPainter {
  final List<Offset> positions;
  final List<Color> colors;
  final List<ShapeType> shapes;

  ConfettiPainter({
    required this.positions,
    required this.colors,
    required this.shapes,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (int i = 0; i < positions.length; i++) {
      paint.color = colors[i % colors.length];
      switch (shapes[i]) {
        case ShapeType.circle:
          canvas.drawCircle(positions[i], 5, paint);
          break;
        case ShapeType.rectangle:
          canvas.drawRect(
            Rect.fromCenter(
              center: positions[i],
              width: 10,
              height: 10,
            ),
            paint,
          );
          break;
        case ShapeType.triangle:
          final path = Path();
          path.moveTo(positions[i].dx, positions[i].dy - 5);
          path.lineTo(positions[i].dx - 5, positions[i].dy + 5);
          path.lineTo(positions[i].dx + 5, positions[i].dy + 5);
          path.close();
          canvas.drawPath(path, paint);
          break;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}