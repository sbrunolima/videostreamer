import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Widgets
import '../profile_screen/profile_option_buttons.dart';
import '../widgets/close_buttom.dart';
import '../widgets/my_app_bar.dart';

class VersionButtom extends StatelessWidget {
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sizedBox,
                const SizedBox(height: 17),
                titles('Version:', '1.0.0', context),
                MyAppBar(),
                const SizedBox(height: 26),
                CloseButtom(),
                const SizedBox(height: 17),
              ],
            ),
          ),
        );
      },
      child: OptionButton(title: 'Version'),
    );
  }

  Widget titles(String title, String subtitle, context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.openSans(
            color: Colors.lightGreenAccent,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          subtitle,
          maxLines: 2,
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
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
            fontWeight: FontWeight.w600,
            fontSize: 16,
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
              fontWeight: FontWeight.w600,
              fontSize: 16,
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
              fontSize: 18,
            ),
          ),
        ],
      );
}
