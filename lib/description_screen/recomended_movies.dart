import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Providers
import '../providers/video_provider.dart';

//Widgets
import '../movies_cards/movie_card_recommend.dart';

class RecomendedMoviesWidget extends StatelessWidget {
  final List<String> movieGenre;
  final String movieID;

  RecomendedMoviesWidget({required this.movieGenre, required this.movieID});

  @override
  Widget build(BuildContext context) {
    //Load all movies
    //-----------------------------------------------------------------------
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video = videoData.video;
    //END Load all movies
    //-----------------------------------------------------------------------

    return MediaQuery.removePadding(
      removeTop: true,
      removeBottom: true,
      context: context,
      child: Container(
        height: 180,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          scrollDirection: Axis.horizontal,
          itemCount: video.length,
          itemBuilder: ((context, index) {
            for (int i = 0; i < movieGenre.length; i++)
              if (video[index].genre.contains(movieGenre[i]) &&
                  video[index].id != movieID) {
                return MovieCardRecommend(video: video[index]);
              }
            return SizedBox.shrink();
          }),
        ),
      ),
    );
  }
}
