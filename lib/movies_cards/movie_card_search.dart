import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

//Objects
import '../objects/video.dart';

//Providers
import '../providers/video_provider.dart';

//Widgets
import '../movies_cards/movie_card.dart';

//Screens
import '../description_screen/movie_description.dart';

class MovieCardSearch extends StatefulWidget {
  final Video video;
  final VoidCallback? onTap;

  MovieCardSearch({
    Key? key,
    required this.video,
    this.onTap,
  }) : super(key: key);
  State<MovieCardSearch> createState() => _MovieCardSearchState();
}

class _MovieCardSearchState extends State<MovieCardSearch> {
  @override
  Widget build(BuildContext context) {
    //Create a const sizedBox to load only one time
    const mySizedBox = SizedBox(height: 6);
    //Create a const mediaQuery to load only one time
    final mediaQuery = MediaQuery.of(context).size;
    //Load all necesary DATA => Video
    return GestureDetector(
      onTap: () {
        //If touched, go to the movies description screen
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MovieDescriptionScreen(
              video: widget.video,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(5),
            color: Colors.black38,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SizedBox(
                    height: 150,
                    width: 110,
                    child: Image.network(
                      widget.video.coverUrl,
                      height: 150,
                      width: 110,
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: mediaQuery.width - 175,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title(widget.video.title),
                        mySizedBox,
                        myText(widget.video.release),
                        mySizedBox,
                      ],
                    ),
                  ),
                )
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
            width: 110,
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

  //directorList Text Formmating
  Widget directorList(var director) => Row(
        children: [
          for (int i = 0; i < director.length; i++)
            Row(
              children: [
                myText('${director[i].toString()}'),
                i < director.length - 1 ? myText(', ') : myText(''),
              ],
            ),
        ],
      );

  //title Text Formmating
  Widget title(String title) => Text(
        title.toString(),
        maxLines: title.toString().length > 18 ? 2 : 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: GoogleFonts.openSans(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      );

  //MyText Text Formmating
  Widget myText(String title) {
    return Text(
      title,
      style: GoogleFonts.openSans(
        color: Colors.grey,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
    );
  }

  //directorText Text Formmating
  Widget directorText(String title) {
    return Text(
      title,
      style: GoogleFonts.openSans(
        color: Colors.grey,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }
}
