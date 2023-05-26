import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:colours/colours.dart';
import 'package:google_fonts/google_fonts.dart';

//Widgets
import '../community_screen/post_item.dart';
import '../community_screen/add_post.dart';
import '../widgets/loading.dart';
import '../widgets/my_title.dart';
import '../errors screen/try_reconnect.dart';

//Providers
import '../providers/user_provider.dart';
import '../providers/post_provider.dart';
import '../providers/comments_provider.dart';
import '../providers/post_likes_provider.dart';
import '../providers/reply_provider.dart';
import '../providers/comment_like_provider.dart';
import '../providers/reply_like_provider.dart';
import '../providers/video_provider.dart';

class CommunutyScreen extends StatefulWidget {
  @override
  State<CommunutyScreen> createState() => _CommunutyScreenState();
}

class _CommunutyScreenState extends State<CommunutyScreen> {
  //Get the user token
  final FirebaseAuth auth = FirebaseAuth.instance;
  //Local and private variables
  var _userId;
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      //Get and set the userID to the variable _userId
      final User? user = auth.currentUser;
      _userId = user!.uid;

      setState(() {
        _isLoading = true;
      });

      //Load all necessary data from firebase to show on screen
      Provider.of<UserPovider>(context, listen: false)
          .loadUsers()
          .then((_) async {
        await Provider.of<VideosProvider>(context, listen: false).loadVideos();
        await Provider.of<PostProvider>(context, listen: false).loadPosts();
        await Provider.of<CommentProvider>(context, listen: false)
            .loadComments();
        await Provider.of<PostLikeProvider>(context, listen: false).loadLikes();

        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  Future<void> _refreshCommunity(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    await //Load all necessary data from firebase to show on screen
        Provider.of<UserPovider>(context, listen: false)
            .loadUsers()
            .then((_) async {
      await Provider.of<VideosProvider>(context, listen: false).loadVideos();
      await Provider.of<PostProvider>(context, listen: false).loadPosts();
      await Provider.of<CommentProvider>(context, listen: false).loadComments();
      await Provider.of<PostLikeProvider>(context, listen: false).loadLikes();

      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //Load and Set - Posts, Users, Videos
    //------------------------------------------------------------------
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final postsData = Provider.of<PostProvider>(context, listen: false);
    final usersData = Provider.of<UserPovider>(context, listen: false);
    final video = videoData.video;
    final post = postsData.posts;
    final user = usersData.user
        .where((loadedUser) => loadedUser.userID == _userId.toString())
        .toList();
    //------------------------------------------------------------------
    //END Load and Set - Posts, Users,  Videos

    return video.isEmpty
        ? TryReconnect()
        : Scaffold(
            backgroundColor: Colors.black54,
            appBar: AppBar(
              backgroundColor: Color.fromARGB(0, 0, 0, 0),
              elevation: 0,
              title: MyTitle(title: 'Community'),
              actions: [
                GestureDetector(
                  onTap: () {
                    _refreshCommunity(context);
                  },
                  child: Row(
                    children: [
                      refreshText('Refresh'),
                      const SizedBox(width: 5),
                      Icon(
                        EneftyIcons.refresh_2_bold,
                        size: 26,
                        color: Colors.lightGreenAccent,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
            body: _isLoading
                ? Loading()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        //Load a list with all posts
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: post.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                PostItem(
                                  post: post[index],
                                  //Receive a BOOL value from Post Item
                                  //And refresh the screen according the BOOL value
                                  callback: (value) {
                                    setState(() {
                                      _isInit = value;
                                    });
                                  },
                                ),
                                const Divider(),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
            floatingActionButton: !_isLoading
                ? FloatingActionButton(
                    child: Icon(
                      EneftyIcons.add_outline,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {
                      //Show a Bottom Modal Sheet to add a new POST
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => DraggableScrollableSheet(
                          initialChildSize: 0.9,
                          minChildSize: 0.5,
                          maxChildSize: 0.9,
                          builder: (_, controller) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                            ),
                            child: AddPost(
                              user: user[0],
                              //Send a call back to refresh the screen
                              callback: (value) {
                                setState(() {
                                  _isInit = value;
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : SizedBox(),
          );
  }

  Widget refreshText(String title) {
    return Text(
      title,
      style: GoogleFonts.openSans(
        color: Colors.lightGreenAccent,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    );
  }
}
