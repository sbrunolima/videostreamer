import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enefty_icons/enefty_icons.dart';

//Widgets
import '../widget_description_screen/rate_row.dart';
import '../providers/video.dart';

class DescriptionTitle extends StatelessWidget {
  final Video video;

  DescriptionTitle({required this.video});

  @override
  Widget build(BuildContext context) {
    final titleWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 500,
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
                  Rect.fromLTRB(0, 200, rect.width, rect.height - 0));
            },
            blendMode: BlendMode.dstIn,
            child: Column(
              children: [
                Image.network(
                  video.bannerUrl.toString(),
                  height: 500,
                  width: titleWidth,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          //Back Button
          Padding(
            padding: const EdgeInsets.all(17),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black45,
                ),
                child: IconButton(
                  icon: const Icon(
                    EneftyIcons.arrow_left_3_outline,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
          //Movie Title
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 130,
              color: Colors.transparent,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      video.title.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //Age, Rate, Genre
                  RateRow(
                    age: video.age.toString(),
                    rate: video.rate.toString(),
                    genre: video.genre,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
