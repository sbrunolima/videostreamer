import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:colours/colours.dart';

//Providers
import '../providers/video_provider.dart';
import '../providers/video.dart';

//Widgets
import '../widgets_description_screen/description_title.dart';
import '../widgets_description_screen/rate_row.dart';
import '../widgets_description_screen/play_button.dart';
import '../widgets_description_screen/all_cast_button.dart';

class CastColumn extends StatelessWidget {
  final Video video;

  CastColumn({required this.video});

  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'The cast',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              AllCastButton(video: video),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: 6,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      video.castImages[index].toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
