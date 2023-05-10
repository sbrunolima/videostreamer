import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
import '../widgets/new_releases.dart';
import '../widgets/featured_rows.dart';

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

      //Load all data from firebase
      Provider.of<CarouselProvider>(context, listen: false).loadCarousel().then(
        (_) async {
          await Provider.of<VideosProvider>(context, listen: false)
              .loadVideos();
          await Provider.of<ImagesProvider>(context, listen: false)
              .loadProfileImages();
          await Provider.of<UserPovider>(context, listen: false).loadUsers();
          await Provider.of<PostProvider>(context, listen: false).loadPosts();
          await Provider.of<CommentProvider>(context, listen: false)
              .loadComments();
          await Provider.of<ReplyProvider>(context, listen: false).loadReply();
          await Provider.of<PostLikeProvider>(context, listen: false)
              .loadLikes();
          await Provider.of<CommentLikeProvider>(context, listen: false)
              .loadLikes();
          await Provider.of<ReplyLikeProvider>(context, listen: false)
              .loadLikes();

          Future.delayed(const Duration(seconds: 2)).then((_) {
            setState(() {
              _isLoading = false;
            });
          });
        },
      );
    }

    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    //Create a cnst sizedBox to load only one time
    const sizedBox = SizedBox(height: 17);
    //Load and Set - Videos
    //------------------------------------------------------------------
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video = videoData.video;
    //------------------------------------------------------------------
    //END Load and Set - Videos

    return video.isNotEmpty
        ? SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black54,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    sizedBox,
                    MyAppBar(),
                    sizedBox,
                    CarouselWidget(),
                    FeaturedRows(receivedData: '2023'),
                    NewReleases(rate: 7.0),
                    GenreRows(movieGenre: 'Crime'),
                    GenreRows(movieGenre: 'Adventure'),
                    GenreRows(movieGenre: 'Comedy'),
                    GenreRows(movieGenre: 'Sci-Fi'),
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
