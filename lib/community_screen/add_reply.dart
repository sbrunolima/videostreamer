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
import '../providers/reply_provider.dart';
import '../providers/images_provider.dart';
import '../providers/user_provider.dart';

//Objects
import '../objects/user.dart';

//Widgets
import '../widgets/my_back_icon.dart';
import '../community_screen/post_profile.dart';
import '../community_screen/post_movie_container.dart';
import '../widgets/my_title.dart';

class AddReply extends StatefulWidget {
  final UserData user;
  final Comments comment;

  AddReply({required this.user, required this.comment});

  @override
  State<AddReply> createState() => _AddReplyState();
}

class _AddReplyState extends State<AddReply> {
  final _observation = FocusNode();
  final _formKey = GlobalKey<FormState>();

  bool _contiueContent = false;
  var _reply = '';

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
    return Scaffold(
      backgroundColor: Color.fromARGB(0, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        titleSpacing: 0,
        leading: MyBackIcon(),
        title: MyTitle(
          title: 'Add new reply',
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
                    _reply = value.toString();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            (_contiueContent) ? Colors.greenAccent : Colors.grey.shade600,
        child: Icon(
          EneftyIcons.send_3_bold,
          color: (_contiueContent) ? Colors.white : Colors.grey.shade700,
          size: 30,
        ),
        onPressed: (_contiueContent)
            ? () async {
                _saveForm();
                await Provider.of<ReplyProvider>(context, listen: false)
                    .sendReply(
                  commentID: widget.comment.id,
                  userID: widget.user.userID,
                  userImage: widget.user.imageUrl,
                  username: widget.user.username,
                  userReply: _reply,
                );

                Navigator.of(context).pop();
              }
            : null,
      ),
    );
  }
}
