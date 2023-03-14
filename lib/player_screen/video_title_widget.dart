import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';

//Widgets
import '../player_screen/video_progress_indicator.dart';
import '../widgets/my_back_icon.dart';

//Providers
import '../providers/video_provider.dart';
import '../providers/video.dart';

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
