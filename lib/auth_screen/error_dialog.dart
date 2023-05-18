import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:colours/colours.dart';

//Return the error while trying to connect with the database
void errorDialog(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: Colors.grey.shade900,
      title: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'ERROR',
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      content: Text(
        message,
        style: GoogleFonts.openSans(
          color: Colors.white,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(5),
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
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
