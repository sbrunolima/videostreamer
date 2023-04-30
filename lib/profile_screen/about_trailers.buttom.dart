import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Widgets
import '../profile_screen/profile_option_buttons.dart';
import '../widgets/close_buttom.dart';

class AboutTrailersButtom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Const sizedbox
    const sizedBox = const SizedBox(height: 6);
    return GestureDetector(
      onTap: () {
        //Show a mogal Bottom Sheet with all the data
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                sizedBox,
                skill('About the Trailers:'),
                sizedBox,
                content(aboutTrailersText[0], context),
                const SizedBox(height: 26),
                CloseButtom(),
                const SizedBox(height: 17),
              ],
            ),
          ),
        );
      },
      child: OptionButton(title: 'About the Trailers'),
    );
  }

  Widget content(String title, context) => Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 20,
            child: Text(
              title,
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
        ],
      );

  Widget skill(String title) => Row(
        children: [
          Text(
            title,
            style: GoogleFonts.openSans(
              color: Colors.lightGreenAccent,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ],
      );

  final List<String> aboutTrailersText = [
    "Cinema Preview is a free, non-profit application that provides users with the opportunity to watch movie trailers. With a wide variety of trailers available, the app is an excellent option for those who want to stay up-to-date with the latest news from the world of cinema.\n\nCinema Preview provides users with an intuitive and easy-to-use user experience. Trailers are organized by genre, making it easy for users to find movie trailers that interest them. The app also provides additional information about the movies such as release date, cast and synopsis.\n\nThe application does not generate profits for the developer, does not infringe copyright laws or condone piracy. This ensures that the film industry and content creators are properly compensated for their work.\n\nCinema Preview is a free, non-profit application that provides users with the opportunity to watch movie trailers in a legal and ethical manner. With a wide range of trailers available and an easy-to-use interface, the app is an excellent choice for those who want to stay up to date on the latest news from the world of cinema.",
  ];
}
