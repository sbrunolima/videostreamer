import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:enefty_icons/enefty_icons.dart';

//Provider
import '../objects/communit_post.dart';
import '../providers/comments_provider.dart';
import '../providers/user_provider.dart';
import '../providers/reply_like_provider.dart';

//Objects
import '../objects/user.dart';

class ReplyItem extends StatefulWidget {
  final Reply reply;
  final UserData user;

  ReplyItem({required this.reply, required this.user});

  @override
  State<ReplyItem> createState() => _ReplyItemState();
}

class _ReplyItemState extends State<ReplyItem> {
  bool _liked = false;
  int _like = 0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    final usersData = Provider.of<UserPovider>(context, listen: false);
    final likeData = Provider.of<ReplyLikeProvider>(context, listen: false);
    final user = usersData.user
        .where((loadedUser) => loadedUser.userID == widget.reply.userID)
        .toList();
    final likes = likeData.like
        .where((loadLikes) =>
            loadLikes.replyID == widget.reply.id &&
            loadLikes.userID == widget.user.userID)
        .toList();
    final likeLength = likeData.like
        .where((loadLikes) => loadLikes.replyID == widget.reply.id)
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
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                          .format(widget.reply.dateTime),
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
                  width: mediaQuery - 100,
                  child: Text(
                    widget.reply.userReply,
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                SizedBox(
                  width: mediaQuery - 100,
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

                              await Provider.of<ReplyLikeProvider>(context,
                                      listen: false)
                                  .addLike(
                                widget.user.userID,
                                widget.reply.id,
                              );
                            }

                            for (int i = 0; i < likes.length; i++)
                              if (likes.isNotEmpty &&
                                  likes[i].replyID == widget.reply.id &&
                                  likes[i].userID == widget.user.userID) {
                                setState(() {
                                  _like = _like - 1;
                                });

                                await Provider.of<ReplyLikeProvider>(context,
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

                            await Provider.of<ReplyLikeProvider>(context,
                                    listen: false)
                                .addLike(
                              widget.user.userID,
                              widget.reply.id,
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
                    ],
                  ),
                ),
                const SizedBox(height: 17),
              ],
            ),
          ],
        ),
      ],
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
