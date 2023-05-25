import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

//Providers
import '../providers/video_provider.dart';

//Widgets
import '../widgets/movie_card.dart';

class MovieSearchList extends StatefulWidget {
  @override
  State<MovieSearchList> createState() => _MovieSearchListState();
}

class _MovieSearchListState extends State<MovieSearchList> {
  @override
  Widget build(BuildContext context) {
    //Create a const sizedBox to load only one time
    const mySizedBox = SizedBox(height: 6);
    //Load all necesary DATA => Video
    //-------------------------------------------------------------------
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video = videoData.findedVideo;
    //-------------------------------------------------------------------
    //END Load all necesary DATA => Video
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: video.length,
      itemBuilder: (ctx, index) {
        return Row(
          children: [
            SizedBox(
              child: MovieCard(video: video[index]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: MediaQuery.of(context).size.width - 170,
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(video[index].title),
                    mySizedBox,
                    myText(video[index].release),
                    mySizedBox,
                  ],
                ),
              ),
            )
          ],
        );
      },
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
          fontSize: 18,
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
