import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_training05/objects/user.dart';

//Provider
import '../objects/communit_post.dart';

//Widgets
import '../community_screen/add_reply.dart';

class ReplyButton extends StatelessWidget {
  final Comments comment;
  final UserData user;

  ReplyButton({required this.comment, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Open a BOTTOM SHEET to add the comment
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            builder: (_, controller) => Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
              //Open the ADD REPLY widget and PASS the user and comment of the reply data
              child: AddReply(
                user: user,
                comment: comment,
              ),
            ),
          ),
        );
      },
      child: Text(
        'Add a reply',
        style: GoogleFonts.openSans(
          color: Colors.greenAccent,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
