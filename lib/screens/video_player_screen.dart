import 'dart:convert';

import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

//Providers
import '../providers/video_provider.dart';
import '../providers/video.dart';

//Widgets
import '../player_screen/video_player_widget.dart';
import '../widgets/my_back_icon.dart';

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
    controller = VideoPlayerController.network(widget.video.trailerURL)
      ..addListener(() => setState(() {}))
      ..setLooping(false)
      ..initialize().then((_) => controller.play());
    setLandscape();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    setAllOrientations();
  }

  Future setLandscape() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    await Wakelock.enable();
  }

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
