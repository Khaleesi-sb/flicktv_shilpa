import 'package:flutter/material.dart';

import '../widgets/feature_tile.dart';

class FeatureListSection extends StatefulWidget {
  final VoidCallback? onAnimationComplete;
  const FeatureListSection({
    super.key,
    required this.onAnimationComplete,
  });

  @override
  State<FeatureListSection> createState() => _FeatureListSectionState();
}

class _FeatureListSectionState extends State<FeatureListSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Animation<double>> _fadeAnims = [];
  final List<Animation<Offset>> _slideAnims = [];

  static const _features = [
    FeatureItem(
      assetPath: 'assets/icons/one_tap_ic.png',
      title: 'Single tap payments',
      subtitle: 'Enjoy seamless payments without the wait for OTPs',
    ),
    FeatureItem(
      assetPath: 'assets/icons/zero_failure_ic.png',
      title: 'Zero failures',
      subtitle: 'Zero payment failures ensure you never miss an order',
    ),
    FeatureItem(
      assetPath: 'assets/icons/refund_ic.png',
      title: 'Real-time refunds',
      subtitle:
          'No need to wait for refunds, blinkit Money refunds are instant!',
    ),
  ];

  @override
  void initState() {
    super.initState();

    // 3 tiles, each 300ms, staggered 150ms apart → total ~900ms
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    for (int i = 0; i < _features.length; i++) {
      final start = (i * 0.2).clamp(0.0, 1.0);
      final end = (start + 0.5).clamp(0.0, 1.0);

      _fadeAnims.add(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeIn),
        ),
      );

      _slideAnims.add(
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(start, end, curve: Curves.easeOut),
          ),
        ),
      );
    }

    _controller.forward().then((_) => widget.onAnimationComplete?.call());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_features.length, (i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: FadeTransition(
              opacity: _fadeAnims[i],
              child: SlideTransition(
                position: _slideAnims[i],
                child: FeatureTile(item: _features[i]),
              ),
            ),
          );
        }),
      ),
    );
  }
}
