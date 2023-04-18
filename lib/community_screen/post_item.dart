import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:math';

//Provider
import '../objects/communit_post.dart';
import '../providers/comments_provider.dart';
import '../providers/post_likes_provider.dart';
import '../providers/user_provider.dart';

//Widgets
import '../community_screen/post_description.dart';
import '../community_screen/post_profile.dart';
import '../community_screen/post_movie_container.dart';

class PostItem extends StatefulWidget {
  final CommunityPost post;
  final Function(bool) callback;

  PostItem({required this.post, required this.callback});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    final commentData = Provider.of<CommentProvider>(context, listen: false);
    final likeData = Provider.of<PostLikeProvider>(context, listen: false);
    final comment = commentData.comments
        .where((loadPost) => loadPost.postID == widget.post.id)
        .toList();
    final likes = likeData.like
        .where((loadlikes) => loadlikes.postID == widget.post.id)
        .toList();

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: ((context) => PostDescription(
                  post: widget.post,
                  //Receive a BOOL value from Post Description
                  //And pass the BOOL value to Community Screen
                  callback: (value) {
                    widget.callback(value);
                  },
                )),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Container(
          height: 170,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostProfile(post: widget.post),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.postTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.post.postContent,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.openSans(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PostMovieContainer(post: widget.post),
                        Row(
                          children: [
                            likeOrCommentCount(
                              likes.length.toString(),
                              EneftyIcons.heart_bold,
                            ),
                            const SizedBox(width: 15),
                            Row(
                              children: [
                                likeOrCommentCount(
                                  comment.length.toString(),
                                  Icons.comment_rounded,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget likeOrCommentCount(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
          size: 20,
        ),
        const SizedBox(width: 5),
        Text(
          title,
          style: GoogleFonts.openSans(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
