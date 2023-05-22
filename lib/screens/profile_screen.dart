import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:colours/colours.dart';
import 'package:google_fonts/google_fonts.dart';

//Providers
import '../providers/user_provider.dart';
import '../providers/video_provider.dart';
import '../providers/images_provider.dart';

//Widgets
import '../profile_screen/exit_button.dart';
import '../profile_screen/profile_data.dart';
import '../widgets/loading.dart';
import '../profile_screen/about_author_buttom.dart';
import '../profile_screen/version_buttom.dart';
import '../profile_screen/privacy_buttom.dart';
import '../profile_screen/about_trailers.buttom.dart';
import '../profile_screen/report_buttom.dart';
import '../errors screen/try_reconnect.dart';

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

      //Load all necessary data from firebase to show on screen
      Provider.of<UserPovider>(context, listen: false)
          .loadUsers()
          .then((_) async {
        await Provider.of<VideosProvider>(context, listen: false).loadVideos();
        await Provider.of<ImagesProvider>(context, listen: false)
            .loadProfileImages();
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    //Create a const sizedBox to load only one time
    const sizedBox = SizedBox(height: 15);
    //Load and Set - Users, Videos
    //------------------------------------------------------------------
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final usersData = Provider.of<UserPovider>(context, listen: false);
    final video = videoData.video;
    final user = usersData.user
        .where((element) => element.userID == _userId.toString())
        .toList();
    //------------------------------------------------------------------
    //END Load and Set - Users, Videos

    return video.isEmpty
        ? TryReconnect(
            callback: (value) {
              setState(() {
                _isInit = value;
              });
            },
          )
        : Scaffold(
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

  //try reconnect th BackEnd
  Widget tryReconnect() {
    return Center(
      child: (!_isLoading)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/nointernet.png',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'No Internet Connection',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 300,
                  child: Text(
                    'Check your internet connection and try again.',
                    style: GoogleFonts.openSans(
                      color: Colors.white54,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 17),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colours.aquamarine,
                          Colours.aqua,
                        ],
                      ),
                    ),
                    child: OutlinedButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });

                        // try load the DATA
                        await Provider.of<VideosProvider>(context,
                                listen: false)
                            .loadVideos();

                        //Await 5 seconds before try to load the page again
                        Future.delayed(const Duration(seconds: 5)).then((_) {
                          setState(() {
                            _isLoading = false;
                          });
                        });
                      },
                      child: Text(
                        'TRY AGAIN',
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Loading(),
    );
  }
}
