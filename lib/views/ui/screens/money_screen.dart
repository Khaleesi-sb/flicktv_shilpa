import 'package:flutter/material.dart';

import '../sections/blinkit_money_section.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/gradient_background.dart';

class MoneyScreen extends StatefulWidget {
  const MoneyScreen({super.key});

  @override
  State<MoneyScreen> createState() => _MoneyScreenState();
}

class _MoneyScreenState extends State<MoneyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlinkitMoneySection(),
            ],
          ),
        ),
      ),
    );
  }
}
