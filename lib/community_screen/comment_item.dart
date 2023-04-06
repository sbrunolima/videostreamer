import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

//Provider
import '../objects/communit_post.dart';
import '../providers/reply_provider.dart';
import '../providers/user_provider.dart';
import '../providers/comment_like_provider.dart';

//Objects
import '../objects/user.dart';

//Widgets
import '../community_screen/reply_button.dart';
import '../community_screen/add_reply.dart';
import '../community_screen/reply_item.dart';
import '../community_screen/replies_list.dart';

class CommentItem extends StatefulWidget {
  final Comments comment;

  CommentItem({required this.comment});

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    final replyData = Provider.of<ReplyProvider>(context, listen: false);
    final usersData = Provider.of<UserPovider>(context, listen: false);
    final reply = replyData.reply
        .where((loadedReplies) => loadedReplies.commentID == widget.comment.id)
        .toList();
    final user = usersData.user
        .where((loadedUser) => loadedUser.userID == widget.comment.userID)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    user[0].imageUrl,
                    height: 25,
                    width: 25,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user[0].username,
                  style: GoogleFonts.openSans(
                    color: Colors.white60,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: mediaQuery - 70,
                  child: Text(
                    widget.comment.userComment,
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: mediaQuery - 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            DateFormat('dd/MM - hh:mm')
                                .format(widget.comment.dateTime),
                            style: GoogleFonts.openSans(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 17),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AddReply(
                                    user: user[0],
                                    comment: widget.comment,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Add a reply',
                              style: GoogleFonts.openSans(
                                color: Colors.greenAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                if (reply.isNotEmpty) repliesExpand(reply.length),
              ],
            ),
          ],
        ),
        SizedBox(height: reply.isNotEmpty ? 10 : 0),
        if (reply.isNotEmpty && _expanded) RepliesList(comment: widget.comment),
        const Divider(),
      ],
    );
  }

  Widget repliesExpand(int replyLength) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _expanded = !_expanded;
        });
      },
      child: Text(
        replyLength > 1 ? '$replyLength replies' : '$replyLength reply',
        style: GoogleFonts.openSans(
          color: Colors.greenAccent,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget likeOrCommentCount(String title) {
    return Text(
      title,
      style: GoogleFonts.openSans(
        color: Colors.grey,
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
