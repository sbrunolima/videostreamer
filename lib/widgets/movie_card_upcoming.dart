import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enefty_icons/enefty_icons.dart';

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
    //Const point text
    const pointText = Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Text('●'),
    );

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
            color: Colors.grey.shade900,
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
                  height: 110,
                  width: 240,
                  color: Colors.grey.shade900,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 65,
                          child: Column(
                            children: [
                              genreList(),
                              const SizedBox(height: 4),
                              title(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            rate(),
                            pointText,
                            age(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Title Widget
  Widget title() {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.video.title,
            maxLines: widget.video.title.toString().length > 18 ? 2 : 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  //Genre Widget
  Widget genreList() => Row(
        children: [
          for (int i = 0; i < widget.video.genre.length; i++)
            Row(
              children: [
                myText(
                  '${widget.video.genre[i].toString()}',
                ),
                i < widget.video.genre.length - 1 ? myText(', ') : myText(''),
              ],
            ),
        ],
      );

  //My Text
  Widget myText(String text) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        color: Colors.white54,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
    );
  }

  //Rate Widget
  Widget rate() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            EneftyIcons.star_bold,
            color: Colors.yellow,
            size: 18,
          ),
          const SizedBox(width: 2),
          Text(
            widget.video.rate.toString() == '0'
                ? '-.-'
                : widget.video.rate.toString().toUpperCase(),
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
        ],
      );

  //Age Widget
  Widget age() => Card(
        color: Colors.green,
        child: SizedBox(
          height: 17,
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
      );

  //Error loading IMAGE
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
