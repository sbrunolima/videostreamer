import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enefty_icons/enefty_icons.dart';

//Widgets
import '../player_screen/video_title_widget.dart';

//Providers
import '../providers/video_provider.dart';
import '../objects/video.dart';

class VideoProgressIdicator extends StatelessWidget {
  final Video video;
  final VideoPlayerController controller;

  VideoProgressIdicator({required this.video, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isMuted = controller.value.volume == 0;

    return Column(
      children: [
        VideoTitleWidget(video: video),
        const SizedBox(height: 17),
        //Progress indicator
        SizedBox(
          height: 5,
          child: VideoProgressIndicator(
            controller,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              backgroundColor: Colors.white24,
              bufferedColor: Colors.white10,
              playedColor: Colors.white70,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Video duration widget
              Container(
                child: Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: controller,
                      builder: (context, VideoPlayerValue value, child) {
                        return Text(
                          _videoDuration(value.position),
                          style: GoogleFonts.roboto(
                            color: Colors.white60,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      },
                    ),
                    Text(
                      '/',
                      style: GoogleFonts.roboto(
                        color: Colors.white60,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      _videoDuration(controller.value.duration),
                      style: GoogleFonts.roboto(
                        color: Colors.white60,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              //Set volume and Report Button
              Container(
                child: Row(
                  children: [
                    Row(
                      children: [
                        if (controller != null &&
                            controller.value.isInitialized)
                          GestureDetector(
                            onTap: () => controller.setVolume(isMuted ? 1 : 0),
                            child: Icon(
                              isMuted
                                  ? Icons.volume_off_outlined
                                  : Icons.volume_up_outlined,
                              color: Colors.white60,
                            ),
                          ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //Video time widget
  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours.remainder(60));
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}
