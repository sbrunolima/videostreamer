import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Providers
import '../objects/video.dart';

//Widgets
import '../widgets/close_buttom.dart';

class StorylineWidget extends StatelessWidget {
  final Video video;

  StorylineWidget({required this.video});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45,
            width: MediaQuery.of(context).size.width,
            child: Text(
              video.storyline[0].toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                height: 1.6,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
          GestureDetector(
            //Open a Bottom Sheet with the storyline text
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
              builder: (context) => bottonSheet(context),
            ),
            child: Text(
              'Read More...',
              style: GoogleFonts.openSans(
                height: 1.6,
                color: Colors.lightGreenAccent,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Bottom Sheet TExt
  Widget bottonSheet(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Story Line',
              style: GoogleFonts.openSans(
                height: 1.6,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              ///Storyline text
              video.storyline[0].toString(),
              style: GoogleFonts.openSans(
                height: 1.6,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 26),
            //Close BUTTOM
            CloseButtom(),
            const SizedBox(height: 17),
          ],
        ),
      );
}
