import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jumping_dot/jumping_dot.dart';

//Providers
import '../objects/video.dart';
import '../providers/video_provider.dart';

//Widgets
import '../widgets/movie_card.dart';
import 'genre_rows.dart';
import '../description_screen/movie_description.dart';

class BannerWidget extends StatelessWidget {
  final String imageUrl;
  final String trailerID;

  BannerWidget({required this.imageUrl, required this.trailerID});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video =
        videoData.video.where((element) => element.id == trailerID).toList();
    return GestureDetector(
      onTap: () {
        for (int i = 0; i < video.length; i++)
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => MovieDescriptionScreen(
                    video: video[i],
                  )),
            ),
          );
      },
      child: Container(
        height: mediaQuery.height,
        width: mediaQuery.width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(6),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            imageUrl,
            fit: BoxFit.fill,
            loadingBuilder:
                (context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: mediaQuery.height,
                width: mediaQuery.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white10),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white30,
                ),
                child: Image.asset(
                  'assets/noimage.png',
                  fit: BoxFit.cover,
                ),
              );
            },
            errorBuilder:
                (BuildContext ctx, Object exception, StackTrace? stackTrace) {
              return Image.asset(
                height: mediaQuery.height,
                width: mediaQuery.width,
                'assets/noimage.png',
              );
            },
          ),
        ),
      ),
    );
  }
}
