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
import '../widgets/loading.dart';
import '../widgets/genre_rows.dart';
import '../widgets/carousel_widget.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/top_imdb_rows.dart';
import '../widgets/featured_rows.dart';
import '../widgets/family_rows.dart';
import '../errors screen/try_reconnect.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        Provider.of<CarouselProvider>(context, listen: false).loadCarousel();

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
    const sizedBox = SizedBox(height: 17);
    const lineHeight = SizedBox(height: 10);
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
                      child: Column(
                        children: [
                          sizedBox,
                          MyAppBar(),
                          sizedBox,
                          CarouselWidget(),
                          FeaturedRows(release: '2023'),
                          lineHeight,
                          GenreRows(movieGenre: 'Crime'),
                          lineHeight,
                          GenreRows(movieGenre: 'Adventure'),
                          lineHeight,
                          GenreRows(movieGenre: 'Comedy'),
                          lineHeight,
                          GenreRows(movieGenre: 'Sci-Fi'),
                          lineHeight,
                          TopIMDbRows(rate: 7.0),
                          lineHeight,
                          GenreRows(movieGenre: 'Horror'),
                          lineHeight,
                          GenreRows(movieGenre: 'Animation'),
                          lineHeight,
                          GenreRows(movieGenre: 'Drama'),
                          lineHeight,
                          FamilyRows(age: 'PG'),
                          lineHeight,
                          GenreRows(movieGenre: 'Fantasy'),
                          lineHeight,
                          GenreRows(movieGenre: 'Mystery'),
                          const SizedBox(height: 40),
                        ],
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
