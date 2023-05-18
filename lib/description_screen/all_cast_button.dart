import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Widgets
import '../profile_screen/profile_option_buttons.dart';
import '../widgets/close_buttom.dart';

class AllCastButtom extends StatelessWidget {
  final List<String> castList;

  AllCastButtom({required this.castList});

  @override
  Widget build(BuildContext context) {
    //Const sizedbox
    const sizedBox = const SizedBox(height: 6);
    return GestureDetector(
      onTap: () {
        //Show a mogal Bottom Sheet with all the data
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBox,
                      title('Cast'),
                      sizedBox,
                      for (int i = 0; i < castList.length; i++)
                        castText(castList[i]),
                      const SizedBox(height: 20),
                      CloseButtom(),
                      const SizedBox(height: 17),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      child: Text(
        'See all...',
        style: GoogleFonts.openSans(
          color: Colors.lightGreenAccent,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  //Title text
  Widget title(String title) => Text(
        title,
        style: GoogleFonts.openSans(
          color: Colors.lightGreenAccent,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      );

  //Cast text
  Widget castText(String title) => Text(
        title,
        style: GoogleFonts.openSans(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      );
}
