import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

//Provider
import '../objects/communit_post.dart';
import '../providers/reply_provider.dart';
import '../providers/user_provider.dart';

//Objects
import '../objects/user.dart';

//Widgets
import '../community_screen/reply_button.dart';
import '../community_screen/add_reply.dart';
import '../community_screen/reply_item.dart';

class RepliesList extends StatelessWidget {
  final Comments comment;
  final UserData user;

  RepliesList({required this.comment, required this.user});

  @override
  Widget build(BuildContext context) {
    final replyData = Provider.of<ReplyProvider>(context, listen: false);
    final reply = replyData.reply
        .where((loadedReplies) => loadedReplies.commentID == comment.id)
        .toList();

    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: reply.length,
        itemBuilder: (context, index) {
          return ReplyItem(
            reply: reply[index],
            user: user,
          );
        },
      ),
    );
  }
}
