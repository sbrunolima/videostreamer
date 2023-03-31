import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:google_fonts/google_fonts.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo3.png',
            scale: 10,
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Loading',
                style: GoogleFonts.audiowide(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 4),
              JumpingDots(
                radius: 4,
                numberOfDots: 3,
                color: Colors.orange,
                animationDuration: Duration(milliseconds: 200),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
