import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:jumping_dot/jumping_dot.dart';

//Widgets
import '../description_screen/play_button.dart';
import '../providers/video.dart';
import '../widgets/my_back_icon.dart';

class DescriptionTitle extends StatelessWidget {
  final Video video;

  DescriptionTitle({required this.video});

  @override
  Widget build(BuildContext context) {
    final titleWidth = MediaQuery.of(context).size.width;
    const sizedBox = SizedBox(width: 5);
    return Container(
      height: 550,
      child: Stack(
        children: [
          //Movie banner
          ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black, Colors.transparent],
                transform: GradientRotation(math.pi / 1),
              ).createShader(
                  Rect.fromLTRB(0, 300, rect.width, rect.height - 0));
            },
            blendMode: BlendMode.dstIn,
            child: Column(
              children: [
                Image.network(
                  video.bannerUrl.toString(),
                  height: 550,
                  width: titleWidth,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 350,
                      width: titleWidth,
                      child: const Align(
                        alignment: Alignment.center,
                        child: JumpingDots(
                          color: Colors.white54,
                          radius: 6,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          //Movie Title
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: video.title.toString().length > 18 ? 250 : 210,
              color: Colors.transparent,
              child: Column(
                children: [
                  movieTitle(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      rate(),
                      sizedBox,
                      age(),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      release(),
                      sizedBox,
                      movieTime(),
                      sizedBox,
                      genreList(),
                    ],
                  ),
                  const SizedBox(height: 17),
                  PlayButton(video: video),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget movieTitle() => Padding(
        padding: const EdgeInsets.all(8.0),
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
          width: 18,
          child: Center(
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
      );

  Widget rate() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            EneftyIcons.star_bold,
            color: Colors.yellow,
            size: 22,
          ),
          const SizedBox(width: 5),
          Text(
            video.rate.toString().toUpperCase(),
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      );

  Widget movieTime() => Row(
        children: [
          const Icon(
            EneftyIcons.timer_2_bold,
            size: 20,
          ),
          const SizedBox(width: 5),
          genreText(video.time.toString().toUpperCase()),
        ],
      );

  Widget release() => Row(
        children: [
          const Icon(
            EneftyIcons.calendar_2_bold,
            size: 20,
          ),
          const SizedBox(width: 5),
          genreText(video.release.toString().toUpperCase()),
        ],
      );

  Widget genreList() => Row(
        children: [
          const Icon(
            EneftyIcons.video_bold,
            size: 20,
          ),
          const SizedBox(width: 5),
          genreText(video.genre.toString().toUpperCase()),
        ],
      );

  Widget textBar() => const Text(
        ' | ',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200),
      );

  Widget genreText(String genre) {
    return Text(
      genre,
      style: GoogleFonts.openSans(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 13,
      ),
    );
  }
}
