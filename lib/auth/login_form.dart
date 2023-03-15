import 'package:flutter/material.dart';

//Screens
import '../screens/signin_screen.dart';

class LoginForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String password,
    BuildContext ctx,
  ) loginFunction;

  LoginForm(this.isLoading, this.loginFunction);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPassword = '';

  void _tryLogin() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.loginFunction(
        _userEmail.trim(),
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
                    key: const ValueKey('password'),
                    validator: (value) {
                      if (value.toString().isEmpty ||
                          value.toString().length < 8) {
                        return 'Enter a 8 character or more password.';
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
                        onPressed: _tryLogin,
                        child: Text('Login'),
                      ),
                    ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => SigninScreen()),
                          ),
                        );
                      },
                      child: Text('Create new account'),
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
