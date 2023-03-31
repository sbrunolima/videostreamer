import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:colours/colours.dart';

//Providers
import '../providers/video_provider.dart';
import '../objects/video.dart';

//Widgets
import '../description_screen/description_title.dart';
import '../description_screen/rate_row.dart';
import '../description_screen/play_button.dart';

//Screens
import '../screens/cast_screen.dart';

class AllCastButton extends StatelessWidget {
  final Video video;

  AllCastButton({required this.video});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: ((context) => CastScreen(
                  video: video,
                )),
          ),
        );
      },
      child: Text(
        'See all',
        style: GoogleFonts.openSans(
          color: Colors.red,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    );
  }
}
