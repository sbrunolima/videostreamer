import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:colours/colours.dart';

//Providers
import '../providers/video_provider.dart';
import '../objects/video.dart';

//Widgets
import '../description_screen/description_title.dart';
import '../description_screen/rate_row.dart';
import '../description_screen/play_button.dart';
import '../description_screen/storyline_widget.dart';
import '../description_screen/recomended_movies.dart';
import '../widgets/my_back_icon.dart';
import '../description_screen/movie_title.dart';

class SuggestionDetailsTab extends StatefulWidget {
  final Video video;

  SuggestionDetailsTab({required this.video});
  @override
  State<SuggestionDetailsTab> createState() => _SuggestionDetailsTabState();
}

class _SuggestionDetailsTabState extends State<SuggestionDetailsTab>
    with SingleTickerProviderStateMixin {
  late final TabController _controller = TabController(length: 2, vsync: this);
  int _index = 0;

  @override
  void initState() {
    super.initState();

    //Listen when the Tab index changes and
    //Add the value to _index variable
    _controller.addListener(() {
      setState(() {
        _index = _controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxTitle = const SizedBox(height: 20);
    const sizedBox = const SizedBox(height: 15);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            child: TabBar(
              controller: _controller,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white54,
              indicatorColor: Colors.white,
              indicatorWeight: 2,
              labelStyle: GoogleFonts.openSans(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              padding: EdgeInsets.symmetric(horizontal: 6),
              onTap: (value) {
                setState(() {
                  _index = value;
                });
              },
              tabs: [
                Tab(text: 'SUGGESTED'),
                Tab(text: 'DETAILS'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            //Check the Tab index and set height according
            height: (_index == 1 && widget.video.castNames.length <= 15)
                ? 850
                : (_index == 1 && widget.video.castNames.length > 15)
                    ? 850
                    : 1050,
            child: TabBarView(
              controller: _controller,
              children: [
                RecomendedMoviesWidget(
                  movieGenre: widget.video.genre,
                  movieID: widget.video.id,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBox,
                    title(widget.video.title),
                    sizedBoxTitle,
                    storyline(widget.video.storyline[0]),
                    sizedBox,
                    details('Duration:', widget.video.time),
                    sizedBox,
                    details('Release Date:', widget.video.release),
                    sizedBox,
                    genreList(),
                    sizedBox,
                    rating(),
                    sizedBox,
                    directors(),
                    sizedBox,
                    cast(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Title Widget
  Widget title(String title) => Text(
        title,
        style: GoogleFonts.openSans(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      );

  //Storyline Widget
  Widget storyline(String title) => Text(
        title,
        style: GoogleFonts.openSans(
          color: Colors.white,
          fontWeight: FontWeight.w300,
          fontSize: 14,
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
  Widget cast() => Flexible(
        child: ListView(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Check the video length
                          //If it is bigger than 15
                          //It will divide the cast names in two columns
                          if (widget.video.castNames.length > 15)
                            for (int i = 0; i < 15; i++)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  myText(
                                      '${widget.video.castNames[i].toString()}'),
                                ],
                              ),

                          //Check the video length
                          //If it is less than 15
                          //It will add a only one cast names column
                          if (widget.video.castNames.length <= 15)
                            for (int i = 0;
                                i < widget.video.castNames.length;
                                i++)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  myText(
                                      '${widget.video.castNames[i].toString()}'),
                                ],
                              ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Check the video length
                          //If it is bigger than 15
                          //It will add a second cast names column
                          if (widget.video.castNames.length > 15)
                            for (int i = 15;
                                i < widget.video.castNames.length;
                                i++)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  myText(
                                      '${widget.video.castNames[i].toString()}'),
                                ],
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
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
