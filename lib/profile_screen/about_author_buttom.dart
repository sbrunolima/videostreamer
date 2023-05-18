import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Widgets
import '../profile_screen/profile_option_buttons.dart';
import '../widgets/close_buttom.dart';

class AboutAuthorButtom extends StatelessWidget {
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
                skill('About the Author:'),
                sizedBox,
                titles('Name:', 'Bruno L. Santos', context),
                sizedBox,
                titles('Role:', 'Flutter Engineer', context),
                sizedBox,
                titles('GitHub:', 'sbrunolima', context),
                const SizedBox(height: 17),
                skill('SKILLS:'),
                sizedBox,
                titles('Programming:', 'Dart, C#, SQL', context),
                sizedBox,
                titles('Frameworks:', 'Flutter, Unity', context),
                sizedBox,
                titles('Spoken Language:', 'Portuguese, English', context),
                sizedBox,
                tools('Tools:', 'Github, Firebase, PostgreSQL, Google Play',
                    context),
                const SizedBox(height: 26),
                CloseButtom(),
                const SizedBox(height: 17),
              ],
            ),
          ),
        );
      },
      child: OptionButton(title: 'About the Author'),
    );
  }

  Widget titles(String title, String subtitle, context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.openSans(
            color: Colors.lightGreenAccent,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          subtitle,
          maxLines: 2,
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget tools(String title, String subtitle, context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.openSans(
            color: Colors.lightGreenAccent,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 6),
        Container(
          width: MediaQuery.of(context).size.width - 100,
          child: Text(
            subtitle,
            maxLines: 2,
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget skill(String title) => Row(
        children: [
          Text(
            title,
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      );
}
