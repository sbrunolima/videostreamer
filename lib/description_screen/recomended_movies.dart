import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//Providers
import '../objects/video.dart';
import '../providers/video_provider.dart';

//Widgets
import '../widgets/movie_card.dart';

class RecomendedMoviesWidget extends StatelessWidget {
  final List<String> movieGenre;
  final String movieID;

  RecomendedMoviesWidget({required this.movieGenre, required this.movieID});

  @override
  Widget build(BuildContext context) {
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video = videoData.video;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'More like this',
                style: GoogleFonts.openSans(
                  color: Colors.white60,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 160,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            itemCount: video.length,
            itemBuilder: (context, index) {
              if (video[index].genre.contains(movieGenre[0]) &&
                  video[index].id != movieID) {
                return MovieCard(video: video[index]);
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
