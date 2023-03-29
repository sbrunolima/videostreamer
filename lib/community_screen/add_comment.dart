import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:math';

//Provider
import '../objects/communit_post.dart';
import '../providers/post_provider.dart';
import '../providers/comments_provider.dart';
import '../providers/images_provider.dart';
import '../providers/user_provider.dart';

//Widgets
import '../widgets/my_back_icon.dart';
import '../community_screen/post_profile.dart';
import '../community_screen/post_movie_container.dart';
import '../widgets/my_title.dart';

class AddComment extends StatefulWidget {
  final CommunityPost post;
  final Function(bool) callback;

  AddComment({required this.post, required this.callback});

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var _userId;
  var _isInit = true;
  var _isLoading = false;
  final _observation = FocusNode();
  final _formKey = GlobalKey<FormState>();

  bool _contiueContent = false;
  var _comment = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final User? user = auth.currentUser;
      _userId = user!.uid;
    }
    _isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
    _observation.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagesData = Provider.of<ImagesProvider>(context, listen: false);
    final usersData = Provider.of<UserPovider>(context, listen: false);
    final images = imagesData.images;
    final user = usersData.user
        .where((element) => element.id == _userId.toString())
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        titleSpacing: 0,
        leading: MyBackIcon(),
        title: MyTitle(
          title: 'Add new comment',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: TextFormField(
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'Enter a Content.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Content',
                  ),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 1000,
                  focusNode: _observation,
                  onFieldSubmitted: (value) {
                    _saveForm();
                  },
                  onChanged: (value) {
                    if (value.toString().length > 0) {
                      setState(() {
                        _contiueContent = true;
                      });
                    } else {
                      setState(() {
                        _contiueContent = false;
                      });
                    }
                  },
                  onSaved: (value) {
                    _comment = value.toString();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 50,
        width: double.infinity,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              IconButton(
                onPressed: (_contiueContent)
                    ? () async {
                        _saveForm();
                        await Provider.of<CommentProvider>(context,
                                listen: false)
                            .sendComment(
                          postID: widget.post.id,
                          userID: _userId,
                          userImage: images[0].imageUrl,
                          username: user[0].username,
                          userComment: _comment,
                        );

                        widget.callback(true);

                        Navigator.of(context).pop();
                      }
                    : null,
                icon: Icon(
                  EneftyIcons.send_3_bold,
                  color: (_contiueContent) ? Colors.white : Colors.white12,
                ),
                iconSize: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
