import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Providers
import '../objects/video.dart';

//Widgets
import '../description_screen/recomended_movies.dart';
import '../description_screen/all_cast_button.dart';

class SuggestionDetailsTab extends StatefulWidget {
  final Video video;

  SuggestionDetailsTab({required this.video});
  @override
  State<SuggestionDetailsTab> createState() => _SuggestionDetailsTabState();
}

class _SuggestionDetailsTabState extends State<SuggestionDetailsTab> {
  @override
  Widget build(BuildContext context) {
    //Const SIZEDBOXs
    const sizedBoxTitle = const SizedBox(height: 20);
    const sizedBox = const SizedBox(height: 15);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        moreLikeThis('More like this:'),
        sizedBox,
        //Call RecomendedMoviesWidget Widget
        //And pass MovieGenre and MovieID
        RecomendedMoviesWidget(
          movieGenre: widget.video.genre,
          movieID: widget.video.id,
        ),
        sizedBoxTitle,
        movieDetailsTitle('Movie details:'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBox,
              details('Duration:', widget.video.time), //Duration
              sizedBox,
              details('Release Date:', widget.video.release), //date
              sizedBox,
              genreList(), //Genres
              sizedBox,
              rating(), //Rating IMDB
              sizedBox,
              directors(), //Directors
              sizedBox,
              castList(), //Cast names
            ],
          ),
        ),
      ],
    );
  }

  //Title Widget
  Widget moreLikeThis(String title) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Row(
          children: [
            Text(
              title,
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );

  //Storyline Widget
  Widget movieDetailsTitle(String title) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Row(
          children: [
            Text(
              title,
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );

  //Details Widget
  Widget details(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.openSans(
            color: Colors.white54,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  //GenreList Widget
  Widget genreList() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Genre:',
            style: GoogleFonts.openSans(
              color: Colors.white54,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              //Check how many Genres the movies has
              //And show all the Genres
              for (int i = 0; i < widget.video.genre.length; i++)
                Row(
                  children: [
                    myText('${widget.video.genre[i].toString()}'),
                    i < widget.video.genre.length - 1 ? Text(', ') : Text(''),
                  ],
                ),
            ],
          ),
        ],
      );

  //Directors Widget
  Widget directors() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Director:',
            style: GoogleFonts.openSans(
              color: Colors.white54,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 3),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Check how many Directors the movies has
              //And show all the directors
              for (int i = 0; i < widget.video.director.length; i++)
                myText('${widget.video.director[i].toString()}'),
            ],
          ),
        ],
      );

  //Cast Widget
  Widget castList() => ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cast:',
                style: GoogleFonts.openSans(
                  color: Colors.white54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 3),
              for (int i = 0; i < 5; i++)
                myText('${widget.video.castNames[i].toString()}'),
              const SizedBox(height: 5),
              AllCastButtom(castList: widget.video.castNames),
            ],
          ),
        ],
      );

  //MyText Widget
  Widget myText(String genre) {
    return Text(
      genre,
      style: GoogleFonts.openSans(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    );
  }

  //Rating Widget
  Widget rating() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rating:',
            style: GoogleFonts.openSans(
              color: Colors.white54,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          Card(
            color: Colors.green,
            child: SizedBox(
              height: 17,
              //Check the age length to identify how many letters is inside
              //And create the Widget according
              width: widget.video.age.length > 1 ? 40 : 20,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    widget.video.age.toString(),
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
