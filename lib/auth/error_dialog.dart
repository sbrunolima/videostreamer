import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Return the error while trying to connect with the database
void errorDialog(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: Colors.grey.shade900,
      title: Column(
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
          child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Close',
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.transparent),
              backgroundColor: Colors.purple.shade800,
            ),
          ),
        ),
      ],
    ),
  );
}
