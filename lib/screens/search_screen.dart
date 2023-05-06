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
import '../widgets/my_app_bar.dart';
import '../search_screen/movies_grid.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });

    Provider.of<CarouselProvider>(context, listen: false).loadCarousel().then(
      (_) async {
        await Provider.of<VideosProvider>(context, listen: false).loadVideos();
        await Provider.of<ImagesProvider>(context, listen: false)
            .loadProfileImages();
        await Provider.of<UserPovider>(context, listen: false).loadUsers();
        await Provider.of<PostProvider>(context, listen: false).loadPosts();
        await Provider.of<CommentProvider>(context, listen: false)
            .loadComments();
        await Provider.of<ReplyProvider>(context, listen: false).loadReply();
        await Provider.of<PostLikeProvider>(context, listen: false).loadLikes();
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

  Future<void> _searchForm(String query) async {
    await Provider.of<VideosProvider>(context, listen: false).findVideo(query);
  }

  @override
  Widget build(BuildContext context) {
    //Create a const sizedBox to load only one time
    const mySizedBox = SizedBox(height: 17);

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
                      //Take the value string and check if the movie exists
                      print('VALUEEE = ${value.length}');
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
