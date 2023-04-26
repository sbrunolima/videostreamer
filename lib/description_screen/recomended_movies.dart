import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Providers
import '../providers/video_provider.dart';

//Widgets
import '../widgets/movie_card_recommend.dart';

class RecomendedMoviesWidget extends StatelessWidget {
  final List<String> movieGenre;
  final String movieID;

  RecomendedMoviesWidget({required this.movieGenre, required this.movieID});

  @override
  Widget build(BuildContext context) {
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video = videoData.video;

    return MediaQuery.removePadding(
      removeTop: true,
      removeBottom: true,
      context: context,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: video.length > 7 ? 8 : video.length,
        itemBuilder: (context, index) {
          return MovieCardRecommend(video: video[index]);
        },
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 260,
          crossAxisSpacing: 0,
          mainAxisSpacing: 10,
          mainAxisExtent: 240,
        ),
      ),
    );
  }
}
