import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:jumping_dot/jumping_dot.dart';

//Widgets
import '../description_screen/play_button.dart';
import '../widgets/my_back_icon.dart';
import '../widgets/loading.dart';

//Objects
import '../objects/video.dart';

class DescriptionTitle extends StatelessWidget {
  final Video video;

  DescriptionTitle({required this.video});

  @override
  Widget build(BuildContext context) {
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
                  Rect.fromLTRB(0, 250, rect.width, rect.height - 10));
            },
            blendMode: BlendMode.dstIn,
            child: Column(
              children: [
                Image.network(
                  video.bannerUrl.toString(),
                  height: 450,
                  width: titleWidth,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 400,
                      width: titleWidth,
                      child: Align(
                        alignment: Alignment.center,
                        child: Loading(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          //Movie Title
        ],
      ),
    );
  }
}
