import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Providers
import '../providers/user_provider.dart';

class SigninForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String userName,
    String password,
    BuildContext ctx,
  ) signinFunction;

  SigninForm(this.isLoading, this.signinFunction);

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySignin() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.signinFunction(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value.toString().isEmpty ||
                          !value.toString().contains('@')) {
                        return 'Enter a valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                    ),
                    onSaved: (value) {
                      _userEmail = value.toString();
                    },
                  ),
                  TextFormField(
                    key: const ValueKey('name'),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Enter a user name.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'User name',
                    ),
                    onSaved: (value) {
                      _userName = value.toString();
                    },
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Enter a valid email address.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    onSaved: (value) {
                      _userPassword = value.toString();
                    },
                  ),
                  const SizedBox(height: 12),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: OutlinedButton(
                        onPressed: _trySignin,
                        child: Text('Signin'),
                      ),
                    ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Alread have a account'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
