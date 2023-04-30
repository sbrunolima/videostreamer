import 'dart:math' as math;
import 'package:flutter/material.dart';

//Widgets
import '../widgets/loading.dart';

//Objects
import '../objects/video.dart';

class DescriptionTitle extends StatelessWidget {
  final Video video;

  DescriptionTitle({required this.video});

  @override
  Widget build(BuildContext context) {
    //Get the device width
    final titleWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 450,
      child: Stack(
        children: [
          //Movie banner
          ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.grey, Colors.transparent],
                transform: GradientRotation(math.pi / 1),
              ).createShader(
                  Rect.fromLTRB(0, 360, rect.width, rect.height - 0));
            },
            blendMode: BlendMode.dstIn,
            child: Column(
              children: [
                Image.network(
                    //Trailer Banner Image
                    video.bannerUrl.toString(),
                    height: 450,
                    width: titleWidth,
                    fit: BoxFit.cover,
                    //If the image is not loaded, show this widget
                    loadingBuilder: (context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 450,
                    width: titleWidth,
                    child: Align(
                      alignment: Alignment.center,
                      child: Loading(),
                    ),
                  );
                }, errorBuilder: (BuildContext ctx, Object exceprion,
                        StackTrace? stackTrace) {
                  return errorLoadingImage(titleWidth);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget errorLoadingImage(double titleWidth) {
    return Container(
      color: Colors.white30,
      child: Image.asset(
        height: 450,
        width: titleWidth,
        'assets/noimage.png',
      ),
    );
  }
}
