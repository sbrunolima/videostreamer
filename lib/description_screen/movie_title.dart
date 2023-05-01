import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enefty_icons/enefty_icons.dart';

//Widgets
import '../description_screen/play_button.dart';
import '../objects/video.dart';

class MovieTitle extends StatelessWidget {
  final Video video;

  MovieTitle({required this.video});

  @override
  Widget build(BuildContext context) {
    //Get the device width
    final mediaQuery = MediaQuery.of(context).size.width;
    //Const SIZEDBOX
    const sizedBox = SizedBox(height: 5);
    //Const point text
    const pointText = Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Text('●'),
    );

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        //Getr the video title length and set the height
        //According to show all title
        height: video.title.toString().length > 20 ? 200 : 165,
        width: mediaQuery,
        color: Colors.transparent,
        child: Column(
          children: [
            movieTitle(), //Title
            sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                rate(), //Rate
                pointText,

                age(), //Age restriction
              ],
            ),
            const SizedBox(height: 6),
            Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  release(), //Release date
                  pointText,
                  movieTime(), //Movie time
                  pointText,
                  genreList(), //Genres
                ],
              ),
            ),
            const SizedBox(height: 10),
            PlayButton(video: video), // Play the trailler
          ],
        ),
      ),
    );
  }

  //Title Widget
  Widget movieTitle() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          video.title.toString(),
          maxLines: video.title.toString().length > 18 ? 2 : 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: GoogleFonts.audiowide(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 28,
          ),
        ),
      );

  //Age Widget
  Widget age() => Card(
        color: Colors.green,
        child: SizedBox(
          height: 17,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                video.age.toString(),
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ),
      );

  //Rate Widget
  Widget rate() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            EneftyIcons.star_bold,
            color: Colors.yellow,
            size: 22,
          ),
          const SizedBox(width: 2),
          Text(
            video.rate.toString() == '0'
                ? '-.-'
                : video.rate.toString().toUpperCase(),
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 4),
        ],
      );

  //Time Widget
  Widget movieTime() => genreText(video.time.toString());

  //Relese Widget
  Widget release() => genreText(video.release.toString());

  //Genre Widget
  Widget genreList() => Row(
        children: [
          for (int i = 0; i < video.genre.length; i++)
            Row(
              children: [
                genreText('${video.genre[i].toString()}'),
                i < video.genre.length - 1 ? Text(', ') : Text(''),
              ],
            ),
        ],
      );

  //Genre Text
  Widget genreText(String genre) {
    return Text(
      genre,
      style: GoogleFonts.openSans(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
    );
  }
}
