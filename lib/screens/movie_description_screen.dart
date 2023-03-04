import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_training05/providers/video.dart';

//Providers
import '../providers/video_provider.dart';

class MovieDescriptionScreen extends StatefulWidget {
  static const routeName = 'description-screen';

  final Video video;

  MovieDescriptionScreen({
    required this.video,
  });

  @override
  State<MovieDescriptionScreen> createState() => _MovieDescriptionScreenState();
}

class _MovieDescriptionScreenState extends State<MovieDescriptionScreen> {
  String ID = '';

  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      Provider.of<VideosProvider>(context, listen: false).loadVideos();
      final videoID = ModalRoute.of(context)!.settings.arguments;
      if (videoID != null) {
        ID = videoID.toString();
        print('ID CHEGADA: ${widget.video.id}');
      }
      print('ID CHEGADA: ${widget.video.id}');
    }

    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final titleWidth = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context).size;
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    //final video = videoData.video.where((videoId) => videoId.id == ID).toList();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 400,
              child: Stack(
                children: [
                  ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black, Colors.transparent],
                        transform: GradientRotation(math.pi / 1),
                      ).createShader(
                          Rect.fromLTRB(0, 200, rect.width, rect.height - 0));
                    },
                    blendMode: BlendMode.dstIn,
                    child: Column(
                      children: [
                        Image.network(
                          widget.video.bannerUrl.toString(),
                          height: 400,
                          width: titleWidth,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        widget.video.title,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(widget.video.rate.toString()),
          ],
        ),
      ),
    );
  }
}
