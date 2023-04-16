import 'package:flutter/material.dart';
import 'package:enefty_icons/enefty_icons.dart';

class MyBackIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        EneftyIcons.arrow_left_3_outline,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
