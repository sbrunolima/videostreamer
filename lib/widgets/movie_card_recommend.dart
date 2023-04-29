import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

//Providers
import '../objects/video.dart';
import '../providers/video_provider.dart';

//Screens
import '../description_screen/movie_description.dart';

class MovieCardRecommend extends StatefulWidget {
  final Video video;
  final VoidCallback? onTap;

  MovieCardRecommend({
    Key? key,
    required this.video,
    this.onTap,
  }) : super(key: key);

  @override
  State<MovieCardRecommend> createState() => _MovieCardRecommendState();
}

class _MovieCardRecommendState extends State<MovieCardRecommend> {
  @override
  Widget build(BuildContext context) {
    final titleWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: ((context) => MovieDescriptionScreen(
                  video: widget.video,
                )),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          height: 180,
          width: 120,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    widget.video.coverUrl.toString(),
                    height: 260,
                    width: 240,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 260,
                        width: 240,
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
                    errorBuilder: (BuildContext ctx, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset(
                        height: 260,
                        width: 240,
                        'assets/noimage.png',
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
