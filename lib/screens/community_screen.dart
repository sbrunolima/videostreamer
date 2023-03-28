import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

//Widgets
import '../community_screen/post_item.dart';
import '../community_screen/add_post.dart';

//Providers
import '../providers/post_provider.dart';
import '../providers/comments_provider.dart';
import '../providers/likes_provider.dart';

class CommunutyScreen extends StatefulWidget {
  @override
  State<CommunutyScreen> createState() => _CommunutyScreenState();
}

class _CommunutyScreenState extends State<CommunutyScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<PostProvider>(context, listen: false).loadPosts();
      Provider.of<LikeProvider>(context, listen: false).loadLikes();
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final postsData = Provider.of<PostProvider>(context, listen: false);
    final post = postsData.posts;
    final commentData = Provider.of<CommentProvider>(context, listen: false);
    final comment = commentData.comments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        title: Text('Community'),
      ),
      body: SingleChildScrollView(
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddPost(
                callback: (value) {
                  setState(() {
                    _isInit = value;
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
