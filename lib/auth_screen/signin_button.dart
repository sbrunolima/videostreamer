import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Screens
import '../screens/signin_screen.dart';

//Singin Button to create new account if the user is new
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
