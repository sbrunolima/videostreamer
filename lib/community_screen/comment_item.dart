import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:enefty_icons/enefty_icons.dart';
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
  final UserData user;

  CommentItem({required this.comment, required this.user});

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool _expanded = false;
  bool _liked = false;
  int _like = 0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    final replyData = Provider.of<ReplyProvider>(context, listen: false);
    final usersData = Provider.of<UserPovider>(context, listen: false);
    final likeData = Provider.of<CommentLikeProvider>(context, listen: false);
    final reply = replyData.reply
        .where((loadedReplies) => loadedReplies.commentID == widget.comment.id)
        .toList();
    final user = usersData.user
        .where((loadedUser) => loadedUser.userID == widget.comment.userID)
        .toList();
    final likes = likeData.like
        .where((loadLikes) =>
            loadLikes.commentID == widget.comment.id &&
            loadLikes.userID == widget.user.userID)
        .toList();
    final likeLength = likeData.like
        .where((loadLikes) => loadLikes.commentID == widget.comment.id)
        .toList();

    if (likes.isNotEmpty) {
      setState(() {
        _liked = likes[0].favorite;
        _like = likeLength.length;
      });
    }

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
                Row(
                  children: [
                    Text(
                      user[0].username,
                      style: GoogleFonts.openSans(
                        color: Colors.white60,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      DateFormat('● dd/MM - hh:mm')
                          .format(widget.comment.dateTime),
                      style: GoogleFonts.openSans(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
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
                const SizedBox(height: 17),
                SizedBox(
                  width: mediaQuery - 70,
                  child: Row(
                    children: [
                      if (likes.isNotEmpty)
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _liked = !_liked;
                            });

                            if (likes.isEmpty) {
                              setState(() {
                                _like = _like + 1;
                              });

                              await Provider.of<CommentLikeProvider>(context,
                                      listen: false)
                                  .addLike(
                                widget.user.userID,
                                widget.comment.id,
                              );
                            }

                            for (int i = 0; i < likes.length; i++)
                              if (likes.isNotEmpty &&
                                  likes[i].commentID == widget.comment.id &&
                                  likes[i].userID == widget.user.userID) {
                                setState(() {
                                  _like = _like - 1;
                                });

                                await Provider.of<CommentLikeProvider>(context,
                                        listen: false)
                                    .deleteLike(
                                  likes[i].id,
                                );
                              }
                          },
                          child: Icon(
                            _liked
                                ? EneftyIcons.heart_bold
                                : EneftyIcons.heart_outline,
                            color: _liked ? Colors.redAccent[400] : Colors.grey,
                            size: 16,
                          ),
                        ),
                      if (likes.isEmpty)
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _liked = !_liked;
                              _like = _like + 1;
                            });

                            await Provider.of<CommentLikeProvider>(context,
                                    listen: false)
                                .addLike(
                              widget.user.userID,
                              widget.comment.id,
                            );
                          },
                          child: Icon(
                            _liked
                                ? EneftyIcons.heart_bold
                                : EneftyIcons.heart_outline,
                            color: _liked ? Colors.redAccent[400] : Colors.grey,
                            size: 16,
                          ),
                        ),
                      const SizedBox(width: 4),
                      likeOrCommentCount(
                        _like.toString(),
                      ),
                      const SizedBox(width: 17),
                      ReplyButton(comment: widget.comment, user: user[0])
                    ],
                  ),
                ),
                const SizedBox(height: 17),
                if (reply.isNotEmpty) repliesExpand(reply.length),
              ],
            ),
          ],
        ),
        SizedBox(height: reply.isNotEmpty ? 10 : 0),
        if (reply.isNotEmpty && _expanded)
          RepliesList(
            comment: widget.comment,
            user: widget.user,
          ),
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
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
