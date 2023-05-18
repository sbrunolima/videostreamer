import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Providers
import '../objects/video.dart';

//Only return the movie name
class VideoTitleWidget extends StatelessWidget {
  final Video video;

  VideoTitleWidget({required this.video});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        children: [
          Text(
            video.title,
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
