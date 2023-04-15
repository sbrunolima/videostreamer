import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:jumping_dot/jumping_dot.dart';

//Widgets
import '../description_screen/play_button.dart';
import '../objects/video.dart';
import '../widgets/my_back_icon.dart';

class MovieTitle extends StatelessWidget {
  final Video video;

  MovieTitle({required this.video});

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(width: 5);
    const pointText = Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Text('●'),
    );
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: video.title.toString().length > 20 ? 210 : 170,
        color: Colors.transparent,
        child: Column(
          children: [
            movieTitle(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                rate(),
                pointText,
                age(),
              ],
            ),
            const SizedBox(height: 6),
            Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  release(),
                  pointText,
                  movieTime(),
                  pointText,
                  genreList(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            PlayButton(video: video),
          ],
        ),
      ),
    );
  }

  Widget movieTitle() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          video.title.toString().toUpperCase(),
          maxLines: video.title.toString().length > 18 ? 2 : 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
      );

  Widget age() => Card(
        color: Colors.green,
        child: SizedBox(
          height: 17,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                video.age.toString(),
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ),
      );

  Widget rate() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            EneftyIcons.star_bold,
            color: Colors.yellow,
            size: 22,
          ),
          const SizedBox(width: 2),
          Text(
            video.rate.toString().toUpperCase(),
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 4),
        ],
      );

  Widget movieTime() => genreText(video.time.toString());

  Widget release() => genreText(video.release.toString());

  Widget genreList() => Row(
        children: [
          for (int i = 0; i < video.genre.length; i++)
            Row(
              children: [
                genreText('${video.genre[i].toString()}'),
                i < video.genre.length - 1 ? Text(', ') : Text(''),
              ],
            ),
        ],
      );

  Widget genreText(String genre) {
    return Text(
      genre,
      style: GoogleFonts.openSans(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
    );
  }
}
