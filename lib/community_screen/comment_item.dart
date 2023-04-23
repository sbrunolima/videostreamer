import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:intl/intl.dart';

//Provider
import '../objects/communit_post.dart';
import '../providers/reply_provider.dart';
import '../providers/user_provider.dart';
import '../providers/comment_like_provider.dart';
import '../providers/comments_provider.dart';

//Objects
import '../objects/user.dart';

//Widgets
import '../community_screen/reply_button.dart';
import '../community_screen/replies_list.dart';

//Comment OBJECT
class CommentItem extends StatefulWidget {
  final Comments comment;
  final UserData user;

  //Callback function to refresh the page
  final Function(bool) callback;

  CommentItem({
    required this.comment,
    required this.user,
    required this.callback,
  });

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  //Expand the reply
  bool _expanded = false;
  //Identify the user has alread liked
  bool _liked = false;
  //Likes count
  int _like = 0;

  @override
  Widget build(BuildContext context) {
    //Take the screen width Size
    final mediaQuery = MediaQuery.of(context).size.width;

    //Load all DATA FROM FIREBASE => Reply, Users, Likes
    //-------------------------------------------------------------------------
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

    //If the likes is not empty on the server, set likes to the server value
    if (likes.isNotEmpty) {
      setState(() {
        _liked = likes[0].favorite;
        _like = likeLength.length;
      });
    }
    //END Load all DATA FROM FIREBASE => Reply, Users, Likes
    //-------------------------------------------------------------------------

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //User IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                user[0].imageUrl,
                height: 25,
                width: 25,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          //User NAME
                          Text(
                            user[0].username,
                            style: GoogleFonts.openSans(
                              color: Colors.white60,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          //Post date
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
                      //If the comment is from the user, it can be deleted
                      if (widget.comment.userID == widget.user.userID)
                        GestureDetector(
                          onTap: () async {
                            //Access the CommentProvider and call the deleteComment function
                            //Delete the comment from firebase
                            await Provider.of<CommentProvider>(context,
                                    listen: false)
                                .deleteComment(commentID: widget.comment.id);

                            //Return true to Post Description Widget
                            widget.callback(true);
                          },
                          child: Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.white70,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                //Comments
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
                //Comment Like buttom
                SizedBox(
                  width: mediaQuery - 70,
                  child: Row(
                    children: [
                      //Identify it is not empty and load the server likes count
                      //And sum with the user new like
                      if (likes.isNotEmpty)
                        GestureDetector(
                          onTap: () async {
                            //Set the _liked to true or false
                            setState(() {
                              _liked = !_liked;
                            });

                            if (likes.isEmpty) {
                              setState(() {
                                _like = _like + 1;
                              });

                              //Access the CommentLikeProvider and call the addLike
                              //Send the user like to firebase
                              await Provider.of<CommentLikeProvider>(context,
                                      listen: false)
                                  .addLike(
                                widget.user.userID,
                                widget.comment.id,
                              );
                            }

                            //Load all likes
                            for (int i = 0; i < likes.length; i++)
                              //If the user alread liked, and he click aggain, it will remove the like
                              if (likes.isNotEmpty &&
                                  likes[i].commentID == widget.comment.id &&
                                  likes[i].userID == widget.user.userID) {
                                //Remove the user like
                                setState(() {
                                  _like = _like - 1;
                                });

                                //Access the CommentLikeProvider and call the deleteLike
                                //Remove the user like to firebase
                                await Provider.of<CommentLikeProvider>(context,
                                        listen: false)
                                    .deleteLike(
                                  likes[i].id,
                                );
                              }
                          },
                          //Identfy if the user like or not and set the colors RED/GREY
                          child: Icon(
                            _liked
                                ? EneftyIcons.heart_bold
                                : EneftyIcons.heart_outline,
                            color: _liked ? Colors.redAccent[400] : Colors.grey,
                            size: 16,
                          ),
                        ),
                      //Identify it is empty and load the server likes count
                      //And add new like
                      if (likes.isEmpty)
                        GestureDetector(
                          onTap: () async {
                            //Set the _liked to true or false
                            //Set the _like to _like + 1
                            setState(() {
                              _liked = !_liked;
                              _like = _like + 1;
                            });

                            //Access the CommentLikeProvider and call the addLike
                            //Send the user like to firebase
                            await Provider.of<CommentLikeProvider>(context,
                                    listen: false)
                                .addLike(
                              widget.user.userID,
                              widget.comment.id,
                            );
                          },
                          //Identfy if the user like or not and set the colors RED/GREY
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
                      //Open the reply screen
                      ReplyButton(comment: widget.comment, user: user[0])
                    ],
                  ),
                ),
                const SizedBox(height: 17),
                //Default is not expanded
                //If not expanded, call repliesExpand and pass the reply length
                if (reply.isNotEmpty) repliesExpand(reply.length),
              ],
            ),
          ],
        ),
        SizedBox(height: reply.isNotEmpty ? 10 : 0),
        //If expanded, call RepliesList and pass all the DATA
        if (reply.isNotEmpty && _expanded)
          RepliesList(
            comment: widget.comment,
            user: widget.user,
            //Receive a BOOL value and refresh the
            //Screen according the BOOL value
            callback: (value) {
              widget.callback(value);
            },
          ),
        const Divider(),
      ],
    );
  }

  //Return a text with the length
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

  //Return a text with the likes and comment count
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
