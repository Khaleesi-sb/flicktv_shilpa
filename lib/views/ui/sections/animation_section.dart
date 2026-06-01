import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import '../widgets/animated_list_view.dart';
import '../widgets/app_button.dart';
import '../widgets/navigator_button.dart';
import '../widgets/text_reveal.dart';

class AnimationSection extends StatefulWidget {
  const AnimationSection({super.key});

  @override
  State<AnimationSection> createState() => _AnimationSectionState();
}

class _AnimationSectionState extends State<AnimationSection> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _showText = false;
  bool _showList = false;
  bool _showFooter = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;
    _controller = AnimationController(
      vsync: this,
      lowerBound: -1000,
      upperBound: 1000,
    );
    _startAnimations();
  }

  bool _initialized = false;
  Future<void> _startAnimations() async {
    // First animation
    await _controller.animateWith(
      SpringSimulation(
        SpringDescription(mass: 0.5, stiffness: 120, damping: 10),
        -75,
        0,
        0,
      ),
    );
    await Future.delayed(const Duration(seconds: 1));
    // Second animation
    await _controller.animateWith(
      SpringSimulation(
        SpringDescription(mass: 0.5, stiffness: 120, damping: 10),
        0,
        -110,
        0,
      ),
    );
    setState(() {
      _showText = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    // Third animation
    await _controller.animateWith(
      SpringSimulation(
        SpringDescription(mass: 0.5, stiffness: 120, damping: 10),
        -110,
        -250,
        0,
      ),
    );
    setState(() {
      _showList = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _showFooter = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _controller.value),
              child: child,
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/icons/wallet_ic.png",
                width: 200,
                height: 200,
              ),
              SizedBox(
                height: 110,
                child: _showText ? TextReveal() : Container(),
              ),
            ],
          ),
        ),
        _showList
            ? Padding(
                padding: const EdgeInsets.only(top: 100.0, left: 22, right: 22),
                child: AnimatedListView(),
              )
            : SizedBox.shrink(),
        _showFooter
            ? Padding(
          padding: const EdgeInsets.only(top: 700.0, left: 22, right: 22),
          child: Column(
            children: [
              AppButton(buttonText: "Add Money"),
              SizedBox(height: 8,),
              NavigatorButton(
                leadingAsset: "assets/icons/gift_ic.png",
                title: "Claim Gift Card",
                subtitle: "Enter gift card details to claim your gift card",
                onTap: () {},
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Enjoy seamless\none tap payments',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF555555),
                  height: 1.1,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
            : SizedBox.shrink(),
      ],
    );
  }
}
