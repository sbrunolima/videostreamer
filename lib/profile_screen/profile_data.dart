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
import '../profile_screen/edit_profile.dart';

class ProfileData extends StatefulWidget {
  final UserData user;

  ProfileData({required this.user});

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  var _isInit = true;
  var _userImage = '';
  var _username = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      Provider.of<UserPovider>(context, listen: false).loadUsers().then((_) {
        setState(() {});
      });
    }

    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white10),
            borderRadius: BorderRadius.circular(50),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              _userImage.isEmpty ? widget.user.imageUrl : _userImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          _username.isEmpty ? widget.user.username : _username,
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => EditProfile(
                      userImage: _userImage.isEmpty
                          ? widget.user.imageUrl
                          : _userImage,
                      username:
                          _username.isEmpty ? widget.user.username : _username,
                      user: widget.user,
                      callback: (image, name) {
                        setState(() {
                          _userImage = image;
                          _username = name;
                        });
                      },
                    )),
              ),
            );
          },
          child: Text(
            'Edit profile',
            style: GoogleFonts.openSans(
              color: Colors.orange,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        )
      ],
    );
  }
}
