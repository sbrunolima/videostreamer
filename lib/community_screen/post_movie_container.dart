import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:math';

//Provider
import '../objects/communit_post.dart';

class PostMovieContainer extends StatelessWidget {
  final CommunityPost post;

  PostMovieContainer({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 110,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(4),
        color: Colors.white10,
      ),
      child: Center(
        child: Row(
          children: [
            const SizedBox(width: 5),
            Icon(
              Icons.movie_filter_sharp,
              color: Colors.greenAccent,
            ),
            const SizedBox(width: 5),
            Container(
              width: 70,
              child: Text(
                post.movie,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.openSans(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
