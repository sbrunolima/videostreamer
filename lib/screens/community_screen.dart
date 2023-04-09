import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Screens
import '../screens/start_screen.dart';

//Widgets
import '../community_screen/post_item.dart';
import '../community_screen/add_post.dart';
import '../widgets/loading.dart';
import '../widgets/my_title.dart';

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

class CommunutyScreen extends StatefulWidget {
  @override
  State<CommunutyScreen> createState() => _CommunutyScreenState();
}

class _CommunutyScreenState extends State<CommunutyScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var _userId;
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final User? user = auth.currentUser;
      _userId = user!.uid;

      setState(() {
        _isLoading = true;
      });

      Provider.of<UserPovider>(context, listen: false).loadUsers().then((_) {
        Provider.of<PostProvider>(context, listen: false).loadPosts();
        Provider.of<PostProvider>(context, listen: false).loadPosts();
        Provider.of<CommentProvider>(context, listen: false).loadComments();
        Provider.of<ReplyProvider>(context, listen: false).loadReply();
        Provider.of<PostLikeProvider>(context, listen: false).loadLikes();
        Provider.of<CommentLikeProvider>(context, listen: false).loadLikes();
        Provider.of<ReplyLikeProvider>(context, listen: false).loadLikes();

        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final postsData = Provider.of<PostProvider>(context, listen: false);
    final usersData = Provider.of<UserPovider>(context, listen: false);
    final post = postsData.posts;
    final user = usersData.user
        .where((loadedUser) => loadedUser.userID == _userId.toString())
        .toList();

    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
          elevation: 0,
          title: MyTitle(title: 'Community')),
      body: _isLoading
          ? Loading()
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: post.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          PostItem(
                            post: post[index],
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          EneftyIcons.add_outline,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () {
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
                    top: Radius.circular(20),
                  ),
                ),
                child: AddPost(
                  user: user[0],
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
      ),
    );
  }
}
