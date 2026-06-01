import 'package:flutter/material.dart';

import 'animated_text_reveal.dart';

class TextReveal extends StatelessWidget {
  const TextReveal({super.key});

  @override
  Widget build(BuildContext context) {
    int delayAmount = 200;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowUp(
          delay: delayAmount,
          child: Text(
            "blinkit",
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w700,
              height: 1.0,
            ),
          ),
        ),
        SizedBox(height: 8),
        ShowUp(
          delay: delayAmount + 300,
          child: Text(
            "MONEY",
            style: TextStyle(
              color: Colors.white,
              fontSize: 56,
              fontWeight: FontWeight.w900,
              letterSpacing: 10,
              height: 0.9,
            ),
          ),
        ),
      ],
    );
  }
}
