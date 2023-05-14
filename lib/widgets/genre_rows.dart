import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

//Providers
import '../providers/video_provider.dart';

//Widgets
import '../widgets/movie_card.dart';

//Return trailers by the genre
class GenreRows extends StatelessWidget {
  final String movieGenre;

  GenreRows({required this.movieGenre});

  @override
  Widget build(BuildContext context) {
    //Load all necesary DATA => Video
    //-------------------------------------------------------------------
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video = videoData.video
        .where((element) => element.genre.contains(movieGenre))
        .toList();
    //-------------------------------------------------------------------
    //END Load all necesary DATA => Video

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            '$movieGenre Movies',
            style: GoogleFonts.openSans(
              color: Colors.white60,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          height: 150,
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
