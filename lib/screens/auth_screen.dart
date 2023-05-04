import 'dart:math' as math;
import 'package:flutter/material.dart';

//Widgets
import '../auth_screen/auth_title.dart';
import '../auth_screen/continue_button.dart';

class AuthScreen extends StatelessWidget {
  //Page route
  static const routeName = '/auth-screen';

  @override
  Widget build(BuildContext context) {
    //Get the device size
    final mediaQuery = MediaQuery.of(context).size;
    //Create a cnst sizedBox to load only one time
    const sizedBox = SizedBox(height: 40);
    return Scaffold(
      body: Container(
        height: mediaQuery.height,
        width: mediaQuery.width,
        child: Stack(
          children: [
            //Create a shader effect
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
              //Backgroung image
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
                    //App title
                    AuthTitle(),
                    sizedBox,
                    //NExt page - Login page Buttom
                    ContinueButton(),
                    sizedBox,
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
