import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

//Widgets
import '../auth_screen/signin_form.dart';
import '../auth_screen/error_dialog.dart';

//Providers
import '../providers/user_provider.dart';

//Screens
import '../screens/start_screen.dart';

class SigninScreen extends StatefulWidget {
  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String username,
    String password,
    BuildContext ctx,
  ) async {
    UserCredential credential;

    try {
      setState(() {
        _isLoading = true;
      });
      credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Provider.of<UserPovider>(context, listen: false).addUser(
        credential.user!.uid,
        email,
        username,
        'https://i.pinimg.com/originals/b1/92/4d/b1924dce177345b5485bb5490ab3441f.jpg',
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
      body: SigninForm(_isLoading, _submitAuthForm),
    );
  }
}
