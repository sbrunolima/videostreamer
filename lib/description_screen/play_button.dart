import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_training05/objects/video.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:colours/colours.dart';

//Widgets
import '../screens/video_player_screen.dart';

class PlayButton extends StatefulWidget {
  final Video video;

  PlayButton({required this.video});

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  @override
  Widget build(BuildContext context) {
    //Get the device width
    final mediaQuery = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 50,
        width: mediaQuery,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(6),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colours.aquamarine,
                Colours.aqua,
              ],
            ),
          ),
          child: OutlinedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  EneftyIcons.play_bold,
                  color: Colors.black,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  'Watch Trailer',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              //Call VideoPlayerScreen and pass the Video Data
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(
                    video: widget.video,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
