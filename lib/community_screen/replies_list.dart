import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Provider
import '../objects/communit_post.dart';
import '../providers/reply_provider.dart';

//Objects
import '../objects/user.dart';

//Widgets
import '../community_screen/reply_item.dart';

class RepliesList extends StatelessWidget {
  final Comments comment;
  final UserData user;

  //Callback function to refresh the page
  final Function(bool) callback;

  RepliesList(
      {required this.comment, required this.user, required this.callback});

  @override
  Widget build(BuildContext context) {
    //Load all DATA FROM FIREBASE => Reply
    //-------------------------------------------------------------------------
    final replyData = Provider.of<ReplyProvider>(context, listen: false);
    final reply = replyData.reply
        .where((loadedReplies) => loadedReplies.commentID == comment.id)
        .toList();
    //END Load all DATA FROM FIREBASE => Reply
    //-------------------------------------------------------------------------

    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: reply.length,
        itemBuilder: (context, index) {
          //Create a OBJECT with every reply
          return ReplyItem(
            reply: reply[index],
            user: user,
            //Return the callback BOOL value to previous widget
            callback: (value) {
              callback(value);
            },
          );
        },
      ),
    );
  }
}
