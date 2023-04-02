import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:colours/colours.dart';

//Screens
import '../screens/login_screen.dart';

//Widgets
import '../auth_screen/auth_title.dart';
import '../auth_screen/continue_button.dart';
import '../auth_screen/signin_button.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth-screen';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: mediaQuery.height,
        width: mediaQuery.width,
        child: Stack(
          children: [
            ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.transparent],
                  transform: GradientRotation(math.pi / 1),
                ).createShader(
                    Rect.fromLTRB(0, 100, rect.width, rect.height - 100));
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                'assets/cinema.jpg',
                height: mediaQuery.height,
                width: mediaQuery.width,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 300,
                width: mediaQuery.width,
                color: Colors.transparent,
                child: Column(
                  children: [
                    AuthTitle(),
                    const SizedBox(height: 40),
                    ContinueButton(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
