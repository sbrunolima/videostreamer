import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Screens
import '../screens/start_screen.dart';

//Providers
import '../providers/images_provider.dart';
import '../providers/user_provider.dart';

//Objects
import '../objects/user.dart';

//Widgets
import '../profile_screen/profile_option_buttons.dart';
import '../profile_screen/exit_button.dart';
import '../widgets/my_back_icon.dart';
import '../widgets/my_title.dart';
import '../profile_screen/profiles_images.dart';

class EditProfile extends StatefulWidget {
  final UserData user;
  final void Function(
    String userImage,
    String username,
  ) callback;

  EditProfile({required this.user, required this.callback});
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var _userId;
  var _isInit = true;
  var _isLoading = false;
  final _observation = FocusNode();
  final _formKey = GlobalKey<FormState>();

  var _imageUrl = '';
  var _newUsername = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final User? user = auth.currentUser;
      _userId = user!.uid;
    }
    _isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
    _observation.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        titleSpacing: 0,
        leading: MyBackIcon(),
        title: MyTitle(
          title: 'Edit profile',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        _imageUrl.isEmpty
                            ? widget.user.imageUrl.toString()
                            : _imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    child: Text(
                      'Change avatar',
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => ProfileImages(
                                callback: (value) {
                                  setState(() {
                                    _imageUrl = value.toString();
                                  });
                                },
                              )),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Username:',
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              TextFormField(
                key: const ValueKey('username'),
                decoration: InputDecoration(
                  hintText: widget.user.username.toString(),
                ),
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                onSaved: (value) {
                  if (value.toString().length > 0) {
                    _newUsername = value.toString();
                  } else {
                    _newUsername = widget.user.username.toString();
                  }
                },
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () async {
                  _saveForm();

                  await Provider.of<UserPovider>(context, listen: false)
                      .editUser(
                    id: widget.user.id,
                    email: widget.user.email,
                    imageUrl:
                        _imageUrl.isEmpty ? widget.user.imageUrl : _imageUrl,
                    userID: _userId,
                    username: _newUsername.isEmpty
                        ? widget.user.username
                        : _newUsername,
                  );

                  widget.callback(
                    _imageUrl.isEmpty ? widget.user.imageUrl : _imageUrl,
                    _newUsername.isEmpty ? widget.user.username : _newUsername,
                  );

                  Navigator.of(context).pop();
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
