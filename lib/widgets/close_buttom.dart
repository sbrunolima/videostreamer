import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:colours/colours.dart';

class CloseButtom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(6),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colours.aquamarine,
              Colours.aqua,
            ],
          ),
        ),
        child: OutlinedButton(
          child: Text(
            'Close',
            style: GoogleFonts.openSans(
              height: 1.6,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          //Close the screen
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
