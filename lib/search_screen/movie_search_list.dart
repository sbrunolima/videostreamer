import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Providers
import '../providers/video_provider.dart';

//Widgets
import '../movies_cards/movie_card_search.dart';

class MovieSearchList extends StatefulWidget {
  @override
  State<MovieSearchList> createState() => _MovieSearchListState();
}

class _MovieSearchListState extends State<MovieSearchList> {
  @override
  Widget build(BuildContext context) {
    //Load all necesary DATA => Video
    //-------------------------------------------------------------------
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video = videoData.findedVideo;
    //-------------------------------------------------------------------
    //END Load all necesary DATA => Video
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: video.length,
      itemBuilder: (ctx, index) {
        return MovieCardSearch(video: video[index]);
      },
    );
  }
}
