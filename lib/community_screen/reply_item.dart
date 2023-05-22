import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:enefty_icons/enefty_icons.dart';

//Provider
import '../objects/communit_post.dart';
import '../providers/user_provider.dart';
import '../providers/reply_like_provider.dart';
import '../providers/reply_provider.dart';

//Objects
import '../objects/user.dart';

class ReplyItem extends StatefulWidget {
  final Reply reply;
  final UserData user;
  final Function(bool) callback;

  ReplyItem({required this.reply, required this.user, required this.callback});

  @override
  State<ReplyItem> createState() => _ReplyItemState();
}

class _ReplyItemState extends State<ReplyItem> {
  bool _liked = false;
  int _like = 0;

  @override
  Widget build(BuildContext context) {
    //Get the device width
    final mediaQuery = MediaQuery.of(context).size;

    //Load all DATA FROM FIREBASE => Users, Likes
    //-------------------------------------------------------------------------
    final usersData = Provider.of<UserPovider>(context, listen: false);
    final likeData = Provider.of<ReplyLikeProvider>(context, listen: false);
    final user = usersData.user
        .where((loadedUser) => loadedUser.userID == widget.reply.userID)
        .toList();
    final hasLike = likeData.like;
    final likes = likeData.like
        .where((loadLikes) =>
            loadLikes.replyID == widget.reply.id &&
            loadLikes.userID == widget.user.userID)
        .toList();
    final likeLength = likeData.like
        .where((loadLikes) => loadLikes.replyID == widget.reply.id)
        .toList();

    //If the likes is not empty on the server, set likes to the server value
    if (hasLike.isNotEmpty) {
      if (likes.isNotEmpty) {
        setState(() {
          _liked = likes[0].favorite;
          _like = likeLength.length;
        });
      } else {
        setState(() {
          _like = likeLength.length;
        });
      }
    }
    //END Load all DATA FROM FIREBASE => Users, Likes
    //-------------------------------------------------------------------------

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                //User Profile Image
                user[0].imageUrl,
                height: 25,
                width: 25,
                fit: BoxFit.cover,
                loadingBuilder:
                    (context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Image.asset(
                    height: 25,
                    width: 25,
                    'assets/noimage.png',
                  );
                },
                errorBuilder: (BuildContext ctx, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    height: 25,
                    width: 25,
                    'assets/noimage.png',
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: mediaQuery.width - 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            //Username
                            user[0].username,
                            style: GoogleFonts.openSans(
                              color: Colors.white60,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            //Reply Date
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
                      //If the user is the owner of the reply, he can delete
                      if (widget.reply.userID == widget.user.userID)
                        GestureDetector(
                          onTap: () async {
                            //Call the ReplyProvider and delete the reply from Firebase
                            await Provider.of<ReplyProvider>(context,
                                    listen: false)
                                .deleteReply(replyID: widget.reply.id);

                            //Return callback BOOL vaue to refresh the screen
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
                SizedBox(
                  width: mediaQuery.width - 100,
                  child: Text(
                    //reply content
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
                  width: mediaQuery.width - 100,
                  child: Row(
                    children: [
                      //Identify it is not empty and load the server likes count
                      //And sum with the user new like
                      if (likes.isNotEmpty)
                        GestureDetector(
                          //Set the _liked to true or false
                          onTap: () async {
                            setState(() {
                              _liked = !_liked;
                            });

                            //Add likes count
                            if (likes.isEmpty) {
                              //Access the ReplyLikeProvider and call the addLike
                              //Send the user like to firebase
                              await Provider.of<ReplyLikeProvider>(context,
                                      listen: false)
                                  .addLike(
                                widget.user.userID,
                                widget.reply.id,
                              );
                            }

                            //Load all likes
                            for (int i = 0; i < likes.length; i++)
                              //If the user alread liked, and he click aggain, it will remove the like
                              if (likes.isNotEmpty &&
                                  likes[i].replyID == widget.reply.id &&
                                  likes[i].userID == widget.user.userID) {
                                //Access the ReplyLikeProvider and call the deleteLike
                                //Remove the user like to firebase
                                await Provider.of<ReplyLikeProvider>(context,
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
                            size: 20,
                          ),
                        ),
                      //Identify it is empty and load the server likes count
                      //And add new like
                      if (likes.isEmpty)
                        GestureDetector(
                          onTap: () async {
                            //Set the _liked to true or false
                            setState(() {
                              _liked = !_liked;
                            });

                            //Access the ReplyLikeProvider and call the addLike
                            //Send the user like to firebase
                            await Provider.of<ReplyLikeProvider>(context,
                                    listen: false)
                                .addLike(
                              widget.user.userID,
                              widget.reply.id,
                            );
                          },
                          //Identfy if the user like or not and set the colors RED/GREY
                          child: Icon(
                            _liked
                                ? EneftyIcons.heart_bold
                                : EneftyIcons.heart_outline,
                            color: _liked ? Colors.redAccent[400] : Colors.grey,
                            size: 20,
                          ),
                        ),
                      const SizedBox(width: 4),
                      //Likes count
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

  //Likes count Text widget
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
