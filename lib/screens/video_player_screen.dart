import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

//Providers
import '../objects/video.dart';

//Widgets
import '../player_screen/video_player_widget.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Video video;

  VideoPlayerScreen({required this.video});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    //Receive the video data and try to play the trailerURL
    controller =
        VideoPlayerController.network(widget.video.trailerURL.toString())
          ..addListener(() => setState(() {}))
          ..setLooping(false)
          ..initialize().then((_) => controller.play());

    //Set the device to landscape mode
    setLandscape();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    setAllOrientations();
  }

  //Set the device to landscape mode
  Future setLandscape() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    await Wakelock.enable();
  }

  //Return to portrait mode if the player is closed
  Future setAllOrientations() async {
    await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);

    await Wakelock.disable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 10,
              //Send the video and the controller to VideoPlayerWidget
              child: VideoPlayerWidget(
                video: widget.video,
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
