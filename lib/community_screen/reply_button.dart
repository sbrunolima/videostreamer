import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:ui_training05/objects/user.dart';

//Provider
import '../objects/communit_post.dart';
import '../providers/comments_provider.dart';
import '../providers/user_provider.dart';

//Objects
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
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddReply(
              user: user,
              comment: comment,
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
