import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:provider/provider.dart';

//Providers
import '../providers/user_provider.dart';
import '../providers/post_provider.dart';
import '../providers/comments_provider.dart';
import '../providers/post_likes_provider.dart';
import '../providers/reply_provider.dart';
import '../providers/comment_like_provider.dart';
import '../providers/reply_like_provider.dart';

//Objects
import '../objects/communit_post.dart';

//Widgets
import '../widgets/my_back_icon.dart';
import '../community_screen/post_profile.dart';
import '../community_screen/post_movie_container.dart';
import '../community_screen/add_comment.dart';
import '../community_screen/comment_item.dart';
import '../widgets/loading.dart';

class PostDescription extends StatefulWidget {
  final CommunityPost post;

  //Callback function to refresh the page
  final Function(bool) callback;

  PostDescription({required this.post, required this.callback});

  @override
  State<PostDescription> createState() => _PostDescriptionState();
}

class _PostDescriptionState extends State<PostDescription> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var _userId;
  var _isInit = true;
  var _isLoading = false;
  bool _liked = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //Load the userID
    if (_isInit) {
      final User? user = auth.currentUser;
      _userId = user!.uid;

      setState(() {
        _isLoading = true;
      });

      //Load all data from Firebase
      Provider.of<PostProvider>(context, listen: false)
          .loadPosts()
          .then((_) async {
        await Provider.of<UserPovider>(context, listen: false).loadUsers();
        await Provider.of<PostProvider>(context, listen: false).loadPosts();
        await Provider.of<CommentProvider>(context, listen: false)
            .loadComments();
        await Provider.of<ReplyProvider>(context, listen: false).loadReply();
        await Provider.of<PostLikeProvider>(context, listen: false).loadLikes();
        await Provider.of<CommentLikeProvider>(context, listen: false)
            .loadLikes();
        await Provider.of<ReplyLikeProvider>(context, listen: false)
            .loadLikes();

        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    //Load all DATA FROM FIREBASE => Comment, Users, Likes
    //-------------------------------------------------------------------------
    final commentData = Provider.of<CommentProvider>(context, listen: false);
    final postLikeData = Provider.of<PostLikeProvider>(context, listen: false);
    final usersData = Provider.of<UserPovider>(context, listen: false);
    final replyData = Provider.of<ReplyProvider>(context, listen: false);
    final replyLikeData =
        Provider.of<ReplyLikeProvider>(context, listen: false);
    final allReplyLikes = replyLikeData.like;
    final allReplies = replyData.reply;
    final user = usersData.user
        .where((loadedUser) => loadedUser.userID == _userId)
        .toList();
    final comment = commentData.comments
        .where((loadPost) => loadPost.postID == widget.post.id)
        .toList();
    final likes = postLikeData.like
        .where((loadlikes) =>
            loadlikes.postID == widget.post.id && loadlikes.userID == _userId)
        .toList();

    //Verify if the likes is not empty
    if (likes.isNotEmpty) {
      //If is not empty, set _liked to the same value the server
      setState(() {
        _liked = likes[0].favorite;
      });
    }
    //END Load all DATA FROM FIREBASE => Comment, Users, Likes
    //-------------------------------------------------------------------------

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        leading: MyBackIcon(),
        actions: [
          //Verify if the user is the owner of the post
          //And show him the delete option
          widget.post.userID == _userId
              ? IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white70,
                  ),
                  onPressed: () async {
                    //Return true to POST ITEM Widget
                    widget.callback(true);

                    //Close the screen
                    Navigator.of(context).pop();

                    //Deletes the POST
                    await Provider.of<PostProvider>(context, listen: false)
                        .deletePost(postID: widget.post.id)
                        .then((_) async {
                      //Deletes all COMMENTS
                      await Provider.of<CommentProvider>(context, listen: false)
                          .deletePostComments(postID: widget.post.id);

                      //Deletes all COMMENTS LIKES
                      for (int i = 0; i < comment.length; i++) {
                        await Provider.of<CommentLikeProvider>(context,
                                listen: false)
                            .deletePostCommentLikes(commentID: comment[i].id);
                      }

                      //Deletes all POST LIKES
                      for (int i = 0; i < likes.length; i++) {
                        await Provider.of<PostLikeProvider>(context,
                                listen: false)
                            .deletePostLikes(postID: widget.post.id);
                      }

                      //Deletes all REPLIES
                      for (int i = 0; i < allReplies.length; i++) {
                        await Provider.of<ReplyProvider>(context, listen: false)
                            .deleteReplyComment(commentID: comment[i].id);
                      }

                      //Deletes all REPLIES LIKES
                      for (int i = 0; i < allReplyLikes.length; i++) {
                        await Provider.of<ReplyLikeProvider>(context,
                                listen: false)
                            .deleteCommentReplyLikes(replyID: allReplies[i].id);
                      }
                    });
                  },
                )
              : const SizedBox(width: 20),
          const SizedBox(width: 10),
        ],
      ),
      //While is loading, show the LOADING widget
      body: _isLoading
          ? Loading()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //Post title
                      widget.post.postTitle,
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    PostProfile(post: widget.post),
                    const SizedBox(height: 20),
                    Text(
                      //Post content
                      widget.post.postContent,
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 10),
                    PostMovieContainer(post: widget.post),
                    const SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Comments',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 5),
                        //Comment length
                        Text(
                          '(${comment.length})',
                          style: GoogleFonts.openSans(
                            color: Colors.white60,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 8),
                    //Show a list of all comments
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: comment.length,
                      itemBuilder: (context, index) {
                        return CommentItem(
                          comment: comment[index],
                          user: user[0],
                          //Receive a BOOL value and refresh the
                          //Screen according the BOOL value
                          callback: (value) {
                            setState(() {
                              _isInit = value;
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
      //Add comment BUTTOM
      persistentFooterButtons: [
        if (!_isLoading)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width - 80,
                child: OutlinedButton(
                  onPressed: () {
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
                          child: AddComment(
                            user: user[0],
                            post: widget.post,
                            //Set _isInit to true after add the comment to refreshe the screen
                            callback: (value) {
                              setState(() {
                                _isInit = value;
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Comment',
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              //POST Like buttom
              //Identify it is not empty and load the server likes count
              //And sum with the user new like
              if (likes.isNotEmpty)
                IconButton(
                  onPressed: () async {
                    //Set the _liked to true or false
                    setState(() {
                      _liked = !_liked;
                    });

                    //Identify it is empty and load the server likes count
                    //And add new like
                    if (likes.isEmpty) {
                      //Access the PostLikeProvider and call the addLike
                      //Send the user like to firebase
                      await Provider.of<PostLikeProvider>(context,
                              listen: false)
                          .addLike(
                        _userId,
                        widget.post.id,
                      );
                    }

                    //Load all likes
                    for (int i = 0; i < likes.length; i++)
                      //If the user alread liked, and he click aggain, it will remove the like
                      if (likes.isNotEmpty &&
                          likes[i].postID == widget.post.id &&
                          likes[i].userID == _userId) {
                        //Access the PostLikeProvider and call the deleteLike
                        //Remove the user like to firebase
                        await Provider.of<PostLikeProvider>(context,
                                listen: false)
                            .deleteLike(
                          likes[i].id,
                        );
                      }
                  },
                  //Identfy if the user like or not and set the colors RED/GREY
                  icon: Icon(
                    _liked ? EneftyIcons.heart_bold : EneftyIcons.heart_outline,
                    color: _liked ? Colors.redAccent[400] : Colors.grey,
                    size: 26,
                  ),
                ),
              //Identify it is empty and load the server likes count
              //And add new like
              if (likes.isEmpty)
                IconButton(
                  onPressed: () async {
                    //Set the _liked to true or false
                    setState(() {
                      _liked = !_liked;
                    });

                    //Access the PostLikeProvider and call the addLike
                    //Send the user like to firebase
                    await Provider.of<PostLikeProvider>(context, listen: false)
                        .addLike(
                      _userId,
                      widget.post.id,
                    );
                  },
                  //Identfy if the user like or not and set the colors RED/GREY
                  icon: Icon(
                    _liked ? EneftyIcons.heart_bold : EneftyIcons.heart_outline,
                    color: _liked ? Colors.redAccent[400] : Colors.grey,
                    size: 26,
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
