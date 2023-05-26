import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Objects
import '../objects/video.dart';

//Screens
import '../description_screen/movie_description.dart';

//Movies card widget
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //If touched, go to the movies description screen
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
        child: SizedBox(
          height: 150,
          width: 110,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.shade900,
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    widget.video.coverUrl.toString(),
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return errorLoadingImage();
                    },
                    errorBuilder: (BuildContext ctx, Object exception,
                        StackTrace? stackTrace) {
                      return errorLoadingImage();
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

  //Error loading IMAGE
  Widget errorLoadingImage() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white38),
        borderRadius: BorderRadius.circular(4),
        color: Colors.white30,
      ),
      child: Stack(
        children: [
          Image.asset(
            height: 150,
            width: 150,
            'assets/noimage.png',
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              widget.video.title,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
