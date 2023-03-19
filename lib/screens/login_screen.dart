import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Widgets
import '../auth_screen/login_form.dart';
import '../auth_screen/error_dialog.dart';

//Screens
import '../screens/start_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    BuildContext ctx,
  ) async {
    UserCredential credential;

    try {
      setState(() {
        _isLoading = true;
      });
      credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        StartScreen.routeName,
        (route) => false,
      );
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('ERROR: $error');
      String message = error.toString();
      errorDialog(message, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginForm(_isLoading, _submitAuthForm),
    );
  }
}
