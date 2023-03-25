import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

//Providers
import '../providers/video.dart';
import '../providers/video_provider.dart';

//Screens
import '../description_screen/movie_description.dart';

//Widgets
import '../widgets/movie_card.dart';

class ActionTest extends StatelessWidget {
  final String movieGenre;

  ActionTest({required this.movieGenre});

  @override
  Widget build(BuildContext context) {
    final titleWidth = MediaQuery.of(context).size.width;
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video = videoData.video
        .where((element) => element.genre == movieGenre)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            '$movieGenre Movies',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          height: 240,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            itemCount: video.length,
            itemBuilder: ((context, index) {
              return MovieCard(video: video[index]);
            }),
          ),
        ),
      ],
    );
  }
}
