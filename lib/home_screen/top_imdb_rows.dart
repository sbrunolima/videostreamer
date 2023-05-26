import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

//Providers
import '../providers/video_provider.dart';
import '../movies_cards/movie_card_upcoming.dart';

class TopIMDbRows extends StatelessWidget {
  final double rate;

  TopIMDbRows({required this.rate});

  Widget build(BuildContext context) {
    //Load all necesary DATA => Video
    //-------------------------------------------------------------------
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video = videoData.video
        .where((element) => double.tryParse(element.rate)! > rate)
        .toList();
    //-------------------------------------------------------------------
    //END Load all necesary DATA => Video

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Top IMDb Rating',
            style: GoogleFonts.openSans(
              color: Colors.white60,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          height: 255,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            itemCount: video.length,
            itemBuilder: ((context, index) {
              return UpcommingVideoCard(video: video[index]);
            }),
          ),
        ),
      ],
    );
  }
}
