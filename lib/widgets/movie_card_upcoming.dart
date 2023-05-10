import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

//Providers
import '../objects/video.dart';
import '../providers/video_provider.dart';

//Screens
import '../description_screen/movie_description.dart';

class UpcommingVideoCard extends StatefulWidget {
  final Video video;
  final VoidCallback? onTap;

  UpcommingVideoCard({
    Key? key,
    required this.video,
    this.onTap,
  }) : super(key: key);

  @override
  State<UpcommingVideoCard> createState() => _UpcommingVideoCardState();
}

class _UpcommingVideoCardState extends State<UpcommingVideoCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: ((context) => MovieDescriptionScreen(
                  video: widget.video,
                )),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                child: Image.network(
                  widget.video.bannerUrl,
                  height: 140,
                  width: 240,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return errorLoadingImage();
                  },
                  errorBuilder:
                      (context, Object exception, StackTrace? stackTrace) {
                    return errorLoadingImage();
                  },
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                child: Container(
                  height: 100,
                  width: 240,
                  color: Colors.grey.shade900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget errorLoadingImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        border: Border.all(color: Colors.transparent),
        color: Colors.white30,
      ),
      child: Stack(
        children: [
          Image.asset(
            height: 138,
            width: 240,
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
}
