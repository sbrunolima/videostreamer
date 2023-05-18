import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Alication APPBAR
class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 40,
        width: 220,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo3.png',
              scale: 17,
            ),
            const SizedBox(width: 5),
            Column(
              children: [
                const SizedBox(height: 12),
                Text(
                  'Cinema Preview',
                  style: GoogleFonts.audiowide(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
