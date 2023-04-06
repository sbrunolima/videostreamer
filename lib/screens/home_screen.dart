import 'dart:math' as math;
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
import '../providers/carousel_provider.dart';
import '../providers/post_provider.dart';
import '../providers/comments_provider.dart';
import '../providers/post_likes_provider.dart';
import '../providers/reply_provider.dart';
import '../providers/comment_like_provider.dart';

//Widgets
import '../widgets/movie_card.dart';
import '../widgets/loading.dart';
import '../widgets/genre_rows.dart';
import '../widgets/banner_widget.dart';
import '../widgets/carousel_widget.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/new_releases.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;
  var _isInit = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });

    Provider.of<CarouselProvider>(context, listen: false).loadCarousel().then(
      (_) {
        Provider.of<VideosProvider>(context, listen: false).loadVideos();
        Provider.of<ImagesProvider>(context, listen: false).loadProfileImages();
        Provider.of<UserPovider>(context, listen: false).loadUsers();
        Provider.of<PostProvider>(context, listen: false).loadPosts();
        Provider.of<CommentProvider>(context, listen: false).loadComments();
        Provider.of<ReplyProvider>(context, listen: false).loadReply();
        Provider.of<PostLikeProvider>(context, listen: false).loadLikes();

        Future.delayed(const Duration(seconds: 2)).then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const mySizedBox = SizedBox(height: 17);
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video = videoData.video;

    return video.isNotEmpty
        ? SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black54,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    mySizedBox,
                    MyAppBar(),
                    mySizedBox,
                    CarouselWidget(),
                    NewReleases(year: '2023'),
                    GenreRows(movieGenre: 'Crime'),
                    GenreRows(movieGenre: 'Adventure'),
                    GenreRows(movieGenre: 'Comedy'),
                    GenreRows(movieGenre: 'SciFi'),
                    GenreRows(movieGenre: 'Horror'),
                    GenreRows(movieGenre: 'Animation'),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          )
        : Loading();
  }
}
