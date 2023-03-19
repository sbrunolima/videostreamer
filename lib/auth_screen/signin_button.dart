import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:colours/colours.dart';

//Screens
import '../screens/login_screen.dart';
import '../screens/signin_screen.dart';

//Widgets
import '../auth_screen/auth_title.dart';

class SigninButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SigninScreen(),
              ),
            );
          },
          child: Text(
            'CREATE NEW ACCOUNT',
            style: GoogleFonts.roboto(
              color: Colors.greenAccent,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
