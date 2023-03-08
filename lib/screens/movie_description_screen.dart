import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:colours/colours.dart';

//Providers
import '../providers/video_provider.dart';
import '../providers/video.dart';

//Widgets
import '../description_screen/description_title.dart';
import '../description_screen/rate_row.dart';
import '../description_screen/play_button.dart';
import '../description_screen/all_cast_button.dart';
import '../description_screen/cast_column.dart';

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
  @override
  Widget build(BuildContext context) {
    final titleWidth = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context).size;
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            DescriptionTitle(video: widget.video),
            const SizedBox(height: 10),
            PlayButton(trailerURL: widget.video.trailerURL),
            const SizedBox(height: 30),
            CastColumn(video: widget.video),
          ],
        ),
      ),
    );
  }
}
