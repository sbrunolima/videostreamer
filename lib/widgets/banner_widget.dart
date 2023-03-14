import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Providers
import '../providers/video.dart';
import '../providers/video_provider.dart';

//Widgets
import '../widgets/movie_card.dart';
import '../widgets/action_test.dart';
import '../screens/movie_description_screen.dart';

class BannerWidget extends StatelessWidget {
  final String imageUrl;
  final String videoID;

  BannerWidget({required this.imageUrl, required this.videoID});

  @override
  Widget build(BuildContext context) {
    final titleWidth = MediaQuery.of(context).size.width;
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video =
        videoData.video.where((element) => element.id == videoID).toList();
    return GestureDetector(
      onTap: () {
        for (int i = 0; i < video.length; i++)
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => MovieDescriptionScreen(
                    video: video[i],
                  )),
            ),
          );
      },
      child: ShaderMask(
        shaderCallback: (rect) {
          return const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black, Colors.transparent],
            transform: GradientRotation(math.pi / 1),
          ).createShader(Rect.fromLTRB(0, 450, rect.width, rect.height - 0));
        },
        blendMode: BlendMode.dstIn,
        child: Column(
          children: [
            Image.network(
              imageUrl,
              height: 550,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              loadingBuilder:
                  (context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 500,
                  width: titleWidth,
                  child: const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(color: Colors.white30),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
