import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//Providers
import '../providers/video.dart';
import '../providers/video_provider.dart';

//Widgets
import '../widgets/movie_card.dart';

class RecomendedMoviesWidget extends StatelessWidget {
  final String movieGenre;

  RecomendedMoviesWidget({required this.movieGenre});

  @override
  Widget build(BuildContext context) {
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video = videoData.video
        .where(((element) => element.genre == movieGenre))
        .toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'More like this',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 250,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            itemCount: video.length,
            itemBuilder: (context, index) {
              return MovieCard(video: video[index]);
            },
          ),
        ),
      ],
    );
  }
}
