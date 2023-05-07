import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//Providers
import '../providers/video_provider.dart';
import '../providers/images_provider.dart';
import '../providers/user_provider.dart';

//Screens
import '../screens/start_screen.dart';

class SplasScreen extends StatefulWidget {
  @override
  State<SplasScreen> createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplasScreen> {
  @override
  void initState() {
    super.initState();

    //Load the necessary data o app start
    Provider.of<VideosProvider>(context, listen: false).loadVideos().then(
      (_) async {
        await Provider.of<ImagesProvider>(context, listen: false)
            .loadProfileImages();
        await Provider.of<UserPovider>(context, listen: false).loadUsers();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StartScreen();
  }
}
