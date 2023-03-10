import 'dart:math' as math;
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//Providers
import '../providers/video_provider.dart';

//Widgets
import '../widgets/movie_card.dart';
import '../widgets/action_test.dart';
import '../widgets/banner_widget.dart';
import '../widgets/carousel_widget.dart';
import '../widgets/my_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<VideosProvider>(context, listen: false).loadVideos();
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    const mySizedBox = SizedBox(height: 20);
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video = videoData.video;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        leading: const Icon(
          EneftyIcons.menu_bold,
          size: 26,
        ),
        title: MyAppBar(),
        actions: const [
          SizedBox(width: 40),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselWidget(),
            mySizedBox,
            ActionTest(movieGenre: 'Action'),
            mySizedBox,
            ActionTest(movieGenre: 'Adventure'),
            mySizedBox,
            ActionTest(movieGenre: 'Comedy'),
            mySizedBox,
            ActionTest(movieGenre: 'SciFi'),
            mySizedBox,
            ActionTest(movieGenre: 'Horror'),
            mySizedBox,
          ],
        ),
      ),
    );
  }
}
