import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:math';

//Provider
import '../objects/communit_post.dart';
import '../providers/comments_provider.dart';
import '../providers/likes_provider.dart';

//Widgets
import '../widgets/my_back_icon.dart';
import '../community_screen/post_profile.dart';
import '../community_screen/post_movie_container.dart';
import '../community_screen/add_comment.dart';
import '../community_screen/comment_item.dart';

class PostDescription extends StatefulWidget {
  final CommunityPost post;

  PostDescription({required this.post});

  @override
  State<PostDescription> createState() => _PostDescriptionState();
}

class _PostDescriptionState extends State<PostDescription> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var _userId;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final User? user = auth.currentUser;
      _userId = user!.uid;

      setState(() {
        _isLoading = true;
      });
      Provider.of<CommentProvider>(context, listen: false)
          .loadComments()
          .then((_) async {
        setState(() {
          setState(() {
            _isLoading = false;
          });
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final commentData = Provider.of<CommentProvider>(context, listen: false);
    final likeData = Provider.of<LikeProvider>(context, listen: false);
    final comment = commentData.comments
        .where((loadPost) => loadPost.postID == widget.post.id)
        .toList();
    final likes = likeData.like
        .where((loadlikes) => loadlikes.postID == widget.post.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        leading: MyBackIcon(),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.postTitle,
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    PostProfile(post: widget.post),
                    const SizedBox(height: 20),
                    Text(
                      widget.post.postContent,
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 10),
                    PostMovieContainer(post: widget.post),
                    const SizedBox(height: 50),
                    Text(
                      'All comments  (${comment.length})',
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 8),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: comment.length,
                      itemBuilder: (context, index) {
                        return CommentItem(comment: comment[index]);
                      },
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: () async {
                await Provider.of<LikeProvider>(context, listen: false).addLike(
                  _userId,
                  widget.post.id,
                );
              },
              child: Icon(
                EneftyIcons.heart_bold,
                color: Colors.white,
                size: 26,
              ),
              backgroundColor: Colors.redAccent[400],
            ),
            const SizedBox(height: 15),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => AddComment(
                          post: widget.post,
                          callback: (value) {
                            setState(() {
                              _isInit = value;
                            });
                          },
                        )),
                  ),
                );
              },
              child: Icon(
                EneftyIcons.add_outline,
                color: Colors.white,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
