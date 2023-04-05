import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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

  ReplyButton({required this.comment});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        'Add a reply',
        style: GoogleFonts.openSans(
          color: Colors.greenAccent,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
