import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                //Movie or Topic title
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
