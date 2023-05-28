import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Widgets
import '../widgets/my_app_bar.dart';
import '../widgets/my_back_icon.dart';
import '../auth_screen/signin_button.dart';

//Login Form Field
class LoginForm extends StatefulWidget {
  final bool isLoading;
  //Return a function to connect
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
  var _showPassword = true;

  //Try to connect the backend server
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        leading: MyBackIcon(),
        title: MyAppBar(),
        actions: const [
          SizedBox(width: 40),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Do you have a Cinema Preview account?',
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const ValueKey('email'),
                  validator: (value) {

                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.white24),
                    ),
                    labelText: 'Email Address',
                  ),
                  onSaved: (value) {
                    _userEmail = value.toString();
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  key: const ValueKey('password'),
                  validator: (value) {

                    return null;
                  },
                  obscureText: _showPassword ? true : false,
                  decoration: InputDecoration(
                    suffixIcon: mySufixIcon(),
                    fillColor: Colors.transparent,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.white24),
                    ),
                    labelText: 'Password',
                  ),
                  onSaved: (value) {
                    _userPassword = value.toString();
                  },
                ),
                const SizedBox(height: 20),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: OutlinedButton(
                      onPressed: _tryLogin,
                      child: Text(
                        'LOGIN',
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(color: Colors.white24),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 30),
                SigninButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Show or Hide te password
  Widget mySufixIcon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: IconButton(
        icon: Icon(
          _showPassword
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: Colors.white54,
        ),
        onPressed: () {
          setState(() {
            _showPassword = !_showPassword;
          });
        },
      ),
    );
  }
}
