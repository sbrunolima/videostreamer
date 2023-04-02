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

//Widgets
import '../profile_screen/profile_option_buttons.dart';
import '../profile_screen/exit_button.dart';
import '../profile_screen/profile_data.dart';
import '../widgets/loading.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  var _userId;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      final User? user = _auth.currentUser;
      _userId = user!.uid;
      setState(() {
        _isLoading = true;
      });

      Provider.of<UserPovider>(context, listen: false).loadUsers().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    const buttonSpace = SizedBox(height: 15);
    final usersData = Provider.of<UserPovider>(context, listen: false);
    final user = usersData.user
        .where((element) => element.userID == _userId.toString())
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
      ),
      body: _isLoading
          ? Loading()
          : SingleChildScrollView(
              child: Column(
                children: [
                  ProfileData(
                    user: user[0],
                  ),
                  const SizedBox(height: 30),
                  OptionButton(title: 'About the Author'),
                  buttonSpace,
                  OptionButton(title: 'About the Trailers'),
                  buttonSpace,
                  OptionButton(title: 'Version notes'),
                  buttonSpace,
                  OptionButton(title: 'Privacy'),
                  const SizedBox(height: 40),
                  ExitButton(),
                ],
              ),
            ),
    );
  }
}
