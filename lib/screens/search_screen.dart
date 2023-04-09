import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//Screens
import '../screens/start_screen.dart';

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
import '../widgets/movie_card.dart';
import '../widgets/my_app_bar.dart';
import '../search_screen/movies_grid.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _observation = FocusNode();
  final _formKey = GlobalKey<FormState>();

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
        Provider.of<CommentLikeProvider>(context, listen: false).loadLikes();
        Provider.of<ReplyLikeProvider>(context, listen: false).loadLikes();

        Future.delayed(const Duration(seconds: 2)).then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      },
    );
  }

  Future<void> _searchForm(String query) async {
    await Provider.of<VideosProvider>(context, listen: false).findVideo(query);
  }

  @override
  Widget build(BuildContext context) {
    const mySizedBox = SizedBox(height: 17);
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video = videoData.findedVideo;
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                mySizedBox,
                MyAppBar(),
                mySizedBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
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
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      hintText: 'What trailer you looking for?',
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                    // onSubmitted: (value) {
                    //   setState(() {
                    //     videoData.findVideo(value.toString());
                    //   });
                    // },
                    onChanged: (value) {
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
}
