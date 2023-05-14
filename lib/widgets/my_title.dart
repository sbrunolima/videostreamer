import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Aplication Tite widget
class MyTitle extends StatelessWidget {
  final String title;

  MyTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.openSans(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
    );
  }
}
