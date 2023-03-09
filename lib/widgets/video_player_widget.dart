import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

//Widgets
import '../widgets/overlay_widget.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return controller != null && controller.value.isInitialized
        ? Container(
            alignment: Alignment.topCenter,
            child: RotatedBox(
              quarterTurns: 1,
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: VideoPlayer(controller),
                  ),
                  Positioned.fill(child: OverlayWidget(controller: controller)),
                ],
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget fullScreen({required Widget child}) {
    final size = controller.value.size;
    final width = size.width;
    final height = size.height;

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}
