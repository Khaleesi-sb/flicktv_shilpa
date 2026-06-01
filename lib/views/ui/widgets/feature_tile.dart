import 'package:flutter/material.dart';

import 'frosted_glass.dart';

class FeatureItem {
  final String assetPath;
  final String title;
  final String subtitle;

  const FeatureItem({
    required this.assetPath,
    required this.title,
    required this.subtitle,
  });
}

class FeatureTile extends StatelessWidget {
  final FeatureItem item;

  const FeatureTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return FrostedGlass.card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Image.asset(
              width: 56,
              height: 56,
              item.assetPath,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  style: TextStyle(
                    color: Colors.white.withAlpha(160),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
