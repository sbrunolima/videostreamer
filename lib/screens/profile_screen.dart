import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

//Providers
import '../providers/user_provider.dart';

//Widgets
import '../profile_screen/exit_button.dart';
import '../profile_screen/profile_data.dart';
import '../widgets/loading.dart';
import '../profile_screen/about_author_buttom.dart';
import '../profile_screen/version_buttom.dart';
import '../profile_screen/privacy_buttom.dart';
import '../profile_screen/about_trailers.buttom.dart';
import '../profile_screen/report_buttom.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //Get a instance of the user
  final _auth = FirebaseAuth.instance;
  var _userId;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      //Get the userID and put it in _userId
      final User? user = _auth.currentUser;
      _userId = user!.uid;
      setState(() {
        _isLoading = true;
      });

      //Load all users
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
    //Create a cnst sizedBox to load only one time
    const sizedBox = SizedBox(height: 15);
    //Load and Set - Users
    //------------------------------------------------------------------
    final usersData = Provider.of<UserPovider>(context, listen: false);
    final user = usersData.user
        .where((element) => element.userID == _userId.toString())
        .toList();
    //------------------------------------------------------------------
    //END Load and Set - Users

    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
      ),
      body: _isLoading
          ? Loading()
          : SingleChildScrollView(
              child: Column(
                children: [
                  //Profile image
                  ProfileData(
                    user: user[0],
                  ),
                  const SizedBox(height: 30),
                  AboutAuthorButtom(), //About author buttom
                  sizedBox,
                  AboutTrailersButtom(), //About TrailersAPP buttom
                  sizedBox,
                  VersionButtom(), //Version buttom
                  sizedBox,
                  PrivacyButtom(), //Privacy buttom
                  sizedBox,
                  ReportButtom(), //Report buttom
                  const SizedBox(height: 40),
                  ExitButton(), //Logout buttom
                ],
              ),
            ),
    );
  }
}
