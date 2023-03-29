import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: JumpingDots(
        radius: 5,
        numberOfDots: 3,
        animationDuration: Duration(milliseconds: 200),
      ),
    );
  }
}
