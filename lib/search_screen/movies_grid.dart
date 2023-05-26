import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Providers
import '../providers/video_provider.dart';

//Widgets
import '../movies_cards/movie_card.dart';

class MovieGrid extends StatefulWidget {
  @override
  State<MovieGrid> createState() => _MovieGridState();
}

class _MovieGridState extends State<MovieGrid> {
  @override
  Widget build(BuildContext context) {
    //Load all necesary DATA => Video
    //-------------------------------------------------------------------
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video = videoData.video;
    //-------------------------------------------------------------------
    //END Load all necesary DATA => Video

    return MediaQuery.removePadding(
      removeTop: true,
      removeBottom: true,
      context: context,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: video.length,
        itemBuilder: (context, index) {
          //Return a grid with all the movies
          return MovieCard(video: video[index]);
        },
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 140,
          crossAxisSpacing: 0,
          mainAxisSpacing: 10,
          mainAxisExtent: 150,
        ),
      ),
    );
  }
}
