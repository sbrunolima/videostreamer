import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

//Widgets
import '../player_screen/video_progress_indicator.dart';
import '../widgets/my_back_icon.dart';
import '../widgets/loading.dart';

//Providers
import '../objects/video.dart';

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
    //Get the device size
    final mediaQuary = MediaQuery.of(context).size;
    print('Altura ${mediaQuary.height}');
    return Column(
      children: [
        Container(
          child: widget.controller.value.isInitialized
              ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    //If touched, show the progress bar
                    if (widget.controller.value.isPlaying) {
                      setState(() {
                        _showProgress = true;
                      });
                    }

                    //After 5 seconds, hide the progress bar
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
                          //Video widget
                          SizedBox(
                            height: mediaQuary.height - 40,
                            width: mediaQuary.width - 20,
                            child: AspectRatio(
                              aspectRatio: widget.controller.value.aspectRatio,
                              child: VideoPlayer(widget.controller),
                            ),
                          ),
                        ],
                      ),
                      //If touched, show the Pause buttom
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
                      //If touched, show the back buttom
                      if (_showProgress || !widget.controller.value.isPlaying)
                        MyBackIcon(),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: mediaQuary.height > 368.0
                            ? mediaQuary.height - 400
                            : mediaQuary.height - 240),
                    Center(
                      child: Loading(),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  //Platy/pause buttom
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
