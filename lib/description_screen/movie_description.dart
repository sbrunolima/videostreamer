import 'package:flutter/material.dart';

//Providers
import '../objects/video.dart';

//Widgets
import '../description_screen/description_title.dart';
import '../description_screen/storyline_widget.dart';
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

class _MovieDescriptionScreenState extends State<MovieDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
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
            DescriptionTitle(video: widget.video), //Description
            MovieTitle(video: widget.video), //Title
            StorylineWidget(video: widget.video), //Storyline
            const SizedBox(height: 20),
            SuggestionDetailsTab(video: widget.video), //Suggestion
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
