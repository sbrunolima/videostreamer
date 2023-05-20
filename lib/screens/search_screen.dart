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
      Provider.of<VideosProvider>(context, listen: false).loadVideos();

      setState(() {
        _isLoading = false;
      });
    }

    _isInit = false;
  }

  Future<void> _searchForm(String query) async {
    await Provider.of<VideosProvider>(context, listen: false).findVideo(query);
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
        ? TryReconnect(
            callback: (value) {
              setState(() {
                _isInit = value;
              });
            },
          )
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: TextField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white24,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  prefixIcon: const Icon(Icons.search,
                                      color: Colors.grey),
                                  hintText: 'What trailer you looking for?',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                ),
                                // onSubmitted: (value) {
                                //   setState(() {
                                //     videoData.findVideo(value.toString());
                                //   });
                                // },
                                onChanged: (value) {
                                  //Take the value string and check if the movie exists
                                  setState(() {
                                    _searchForm(value.toString());
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            MovieGrid(),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
  }

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
