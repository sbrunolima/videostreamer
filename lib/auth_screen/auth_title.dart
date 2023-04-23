import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//The APP title in the Auth Screen
class AuthTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo3.png',
              scale: 12,
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Cinema Preview',
                  style: GoogleFonts.audiowide(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: 250,
          child: Text(
            'Discover the Magic of Cinema, Anywhere You Go.',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              color: Colors.white70,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
