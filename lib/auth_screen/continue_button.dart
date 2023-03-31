import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:colours/colours.dart';

//Screens
import '../screens/login_screen.dart';
import '../screens/signin_screen.dart';

//Widgets
import '../auth_screen/auth_title.dart';

class ContinueButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
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
            child: Text(
              'Continue',
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
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
