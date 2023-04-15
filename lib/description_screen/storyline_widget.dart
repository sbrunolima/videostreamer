import 'package:flutter/material.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:colours/colours.dart';

//Providers
import '../providers/video_provider.dart';
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
            height: 53,
            width: MediaQuery.of(context).size.width,
            child: Text(
              video.storyline[0].toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                height: 1.6,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
          GestureDetector(
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
                color: Colors.red,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

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
              video.storyline[0].toString(),
              style: GoogleFonts.openSans(
                height: 1.6,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 26),
            CloseButtom(),
            const SizedBox(height: 17),
          ],
        ),
      );
}
