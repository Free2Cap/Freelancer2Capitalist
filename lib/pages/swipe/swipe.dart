import 'package:flutter/material.dart';
import 'package:freelancer2capitalist/pages/swipe/widgets/background_curve_widget.dart';
import 'package:freelancer2capitalist/pages/swipe/widgets/cards_stack_widget.dart';

class SwipeCard extends StatelessWidget {
  const SwipeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: const [
          BackgroudCurveWidget(),
          CardsStackWidget(),
        ],
      ),
    );
  }
}

enum Swipe { left, right, none }
