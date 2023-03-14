import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';

//Widgets
import '../player_screen/video_progress_indicator.dart';
import '../widgets/my_back_icon.dart';

//Providers
import '../providers/video_provider.dart';
import '../providers/video.dart';

class VideoPlayerWidget extends StatefulWidget {
  final Video video;
  final VideoPlayerController controller;

  VideoPlayerWidget({required this.video, required this.controller});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuary = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          child: widget.controller.value.isInitialized
              ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (widget.controller.value.isPlaying) {
                      setState(() {
                        _showProgress = true;
                      });
                    }

                    Future.delayed(const Duration(seconds: 5)).then((_) {
                      setState(() {
                        _showProgress = false;
                      });
                    });
                  },
                  child: Stack(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 40,
                            width: MediaQuery.of(context).size.width - 20,
                            child: AspectRatio(
                              aspectRatio: widget.controller.value.aspectRatio,
                              child: VideoPlayer(widget.controller),
                            ),
                          ),
                        ],
                      ),
                      if (_showProgress || !widget.controller.value.isPlaying)
                        buildPlay(),
                      if (_showProgress || !widget.controller.value.isPlaying)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: VideoProgressIdicator(
                            video: widget.video,
                            controller: widget.controller,
                          ),
                        ),
                      if (_showProgress || !widget.controller.value.isPlaying)
                        MyBackIcon(),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: mediaQuary.height - 220),
                    const Center(
                      child: CircularProgressIndicator(color: Colors.white30),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Widget buildPlay() {
    return Positioned(
      bottom: 0,
      left: 0,
      top: 0,
      right: 0,
      child: Container(
        alignment: Alignment.center,
        color: Colors.black45,
        child: OutlinedButton(
          child: Icon(
            widget.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
            size: 60,
          ),
          onPressed: () => widget.controller.value.isPlaying
              ? widget.controller.pause()
              : widget.controller.play(),
        ),
      ),
    );
  }
}
