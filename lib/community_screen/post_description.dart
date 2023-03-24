import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:math';

//Provider
import '../providers/communit_post.dart';

//Widgets
import '../widgets/my_back_icon.dart';
import '../community_screen/post_profile.dart';
import '../community_screen/post_movie_container.dart';

class PostDescription extends StatefulWidget {
  final CommunityPost post;

  PostDescription({required this.post});

  @override
  State<PostDescription> createState() => _PostDescriptionState();
}

class _PostDescriptionState extends State<PostDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        leading: MyBackIcon(),
      ),
      body: Padding(
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
            PostMovieContainer(post: widget.post),
            const SizedBox(height: 10),
            const Divider(),
            Text(
              'All comments  (${widget.post.comments.length})',
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            for (int i = 0; i < widget.post.comments.length; i++)
              Text(widget.post.comments[i].userComment),
          ],
        ),
      ),
    );
  }
}
