import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//Providers
import '../providers/user_provider.dart';

//Objects
import '../objects/user.dart';

//Widgets
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

    //Load all users
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
        //User image widget
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
        //Username widget
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
            //Go to the EditProfile to edit the profile
            //Send all the actiual data to EditProfile screen
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => EditProfile(
                      userImage: _userImage.isEmpty
                          ? widget.user.imageUrl
                          : _userImage,
                      username:
                          _username.isEmpty ? widget.user.username : _username,
                      user: widget.user,
                      //When returned, set the data with te new data
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
