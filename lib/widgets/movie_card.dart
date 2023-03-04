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
        print('ID IDA: ${widget.video.id}');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 200,
          width: 150,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.video.imageUrl.toString(),
                    height: 200,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 50,
                      width: titleWidth,
                      color: Colors.black45,
                      child: Text(
                        widget.video.title.toString(),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
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
