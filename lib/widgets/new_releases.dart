import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

//Providers
import '../objects/video.dart';
import '../providers/video_provider.dart';

//Screens
import '../description_screen/movie_description.dart';

//Widgets
import '../widgets/movie_card.dart';

class NewReleases extends StatelessWidget {
  final String year;

  NewReleases({required this.year});

  @override
  Widget build(BuildContext context) {
    final titleWidth = MediaQuery.of(context).size.width;
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video =
        videoData.video.where((element) => element.release == year).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            '$year Releases',
            style: GoogleFonts.roboto(
              color: Colors.white60,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          height: 160,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            itemCount: video.length,
            itemBuilder: ((context, index) {
              return MovieCard(video: video[index]);
            }),
          ),
        ),
      ],
    );
  }
}
