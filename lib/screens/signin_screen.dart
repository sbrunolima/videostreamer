import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

//Widgets
import '../auth/signin_form.dart';
import '../auth/error_dialog.dart';

//Providers
import '../providers/user_provider.dart';

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

      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(credential.user!.uid)
      //     .set(
      //   {
      //     'userName': username,
      //     'email': email,
      //   },
      // );

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
