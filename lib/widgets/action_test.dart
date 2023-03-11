import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

//Providers
import '../providers/video.dart';
import '../providers/video_provider.dart';

//Screens
import '../screens/movie_description_screen.dart';

class ActionTest extends StatelessWidget {
  final String title;

  ActionTest({required this.title});

  @override
  Widget build(BuildContext context) {
    final titleWidth = MediaQuery.of(context).size.width;
    final videoData = Provider.of<VideosProvider>(context, listen: false);
    final video =
        videoData.video.where((element) => element.genre == title).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            '$title Movies',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          height: 240,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            itemCount: video.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => MovieDescriptionScreen(
                            video: video[index],
                          )),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                              video[index].imageUrl.toString(),
                              height: 240,
                              width: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
