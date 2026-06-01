import 'package:flutter/material.dart';

import 'feature_tile.dart';

class AnimatedListView extends StatefulWidget {
  const AnimatedListView({super.key});

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
  State<AnimatedListView> createState() => _AnimatedListViewState();
}

class _AnimatedListViewState extends State<AnimatedListView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<FeatureItem> _items = [];

  @override
  void initState() {
    super.initState();
    _insertItems();
  }
  Future<void> _insertItems() async {
    for (int i = 0; i < AnimatedListView._features.length; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      _items.add(AnimatedListView._features[i]);
      _listKey.currentState?.insertItem(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      initialItemCount: _items.length,
      itemBuilder: (context, index, animation) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.9,
              end: 1.0,
            ).animate(curved),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(curved),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: FeatureTile(
                  item: _items[index],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
