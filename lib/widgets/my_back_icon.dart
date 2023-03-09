import 'package:flutter/material.dart';
import 'package:enefty_icons/enefty_icons.dart';

class MyBackIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
            color: Colors.black45,
          ),
          child: IconButton(
            icon: const Icon(
              EneftyIcons.arrow_left_3_outline,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
