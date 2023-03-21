import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//Providers
import '../providers/video_provider.dart';
import '../providers/video.dart';

//Widgets
import '../widgets/movie_card.dart';
import '../widgets/my_app_bar.dart';

class MovieGrid extends StatefulWidget {
  @override
  State<MovieGrid> createState() => _MovieGridState();
}

class _MovieGridState extends State<MovieGrid> {
  var _isLoading = false;
  var _isInit = true;

  @override
  void initState() {
    super.initState();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<VideosProvider>(context, listen: false)
          .loadVideos()
          .then((_) async {
        setState(() {
          setState(() {
            _isLoading = true;
          });
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video = videoData.findedVideo;
    return MediaQuery.removePadding(
      removeTop: true,
      removeBottom: true,
      context: context,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: video.length,
        itemBuilder: (context, index) {
          return MovieCard(video: video[index]);
        },
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 240,
        ),
      ),
    );
  }
}
