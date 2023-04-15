import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:colours/colours.dart';

//Providers
import '../providers/video_provider.dart';
import '../objects/video.dart';

//Widgets
import '../description_screen/description_title.dart';
import '../description_screen/rate_row.dart';
import '../description_screen/play_button.dart';
import '../description_screen/storyline_widget.dart';
import '../description_screen/recomended_movies.dart';
import '../widgets/my_back_icon.dart';
import '../description_screen/movie_title.dart';
import '../description_screen/suggestion_details_tab.dart';

class MovieDescriptionScreen extends StatefulWidget {
  static const routeName = 'description-screen';

  final Video video;

  MovieDescriptionScreen({
    required this.video,
  });

  @override
  State<MovieDescriptionScreen> createState() => _MovieDescriptionScreenState();
}

class _MovieDescriptionScreenState extends State<MovieDescriptionScreen>
    with SingleTickerProviderStateMixin {
  late final TabController controller = TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    final titleWidth = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context).size;
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        leading: MyBackIcon(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DescriptionTitle(video: widget.video),
            MovieTitle(video: widget.video),
            StorylineWidget(video: widget.video),
            const SizedBox(height: 20),
            SuggestionDetailsTab(video: widget.video),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
