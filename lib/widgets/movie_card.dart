import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

//Providers
import '../providers/video.dart';
import '../providers/video_provider.dart';

//Screens
import '../screens/movie_description_screen.dart';

class MovieCard extends StatefulWidget {
  final Video video;
  final VoidCallback? onTap;

  MovieCard({
    Key? key,
    required this.video,
    this.onTap,
  }) : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  void _navigate() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((context) => MovieDescriptionScreen(
              video: widget.video,
            )),
      ),
    );
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          height: 240,
          width: 160,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Image.network(
                    widget.video.imageUrl.toString(),
                    height: 240,
                    width: 160,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Image.asset(
                        'assets/noimage.png',
                        height: 240,
                        width: 160,
                        fit: BoxFit.cover,
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
