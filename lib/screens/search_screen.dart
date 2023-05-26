import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:colours/colours.dart';
import 'package:google_fonts/google_fonts.dart';

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
import '../providers/reply_like_provider.dart';

//Widgets
import '../widgets/my_app_bar.dart';
import '../search_screen/movies_grid.dart';
import '../errors screen/try_reconnect.dart';
import '../widgets/loading.dart';
import '../search_screen/search_bar.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      //Load all necessary data from firebase to show on screen
      Provider.of<VideosProvider>(context, listen: false)
          .loadVideos()
          .then((_) {
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
    const mySizedBox = SizedBox(height: 17);
    //Load and Set - Videos
    //------------------------------------------------------------------
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video = videoData.video;
    //------------------------------------------------------------------
    //END Load and Set - Videos

    return video.isEmpty
        ? TryReconnect()
        : Scaffold(
            backgroundColor: Colors.black54,
            body: _isLoading
                ? Loading()
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            mySizedBox,
                            MyAppBar(),
                            mySizedBox,
                            SearchBar(),
                            const SizedBox(height: 20),
                            MovieGrid(),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
  }
}
