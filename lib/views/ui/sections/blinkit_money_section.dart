import 'package:flutter/material.dart';

// import '../widgets/custom_confetti/confetti_animation.dart';
import '../widgets/custom_confetti/confetti_animation.dart';
import 'animation_section.dart';

class BlinkitMoneySection extends StatelessWidget {
  final VoidCallback? onAnimationComplete;

  const BlinkitMoneySection({
    super.key,
    this.onAnimationComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        const ConfettiAnimation(),
        AnimationSection(),
      ],
    );
  }
}