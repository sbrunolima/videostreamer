import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

class AddPost extends StatefulWidget {
  final Function(bool) callback;

  AddPost({required this.callback});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var _userId;
  var _isInit = true;
  var _isLoading = false;
  final _observation = FocusNode();
  final _formKey = GlobalKey<FormState>();

  var postContent = '';
  var postTitle = '';
  var movie = '';

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
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        leading: MyBackIcon(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                key: const ValueKey('title'),
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                onSaved: (value) {
                  postTitle = value.toString();
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                key: const ValueKey('movie'),
                decoration: const InputDecoration(
                  hintText: 'Category or Movie',
                ),
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                onSaved: (value) {
                  movie = value.toString();
                },
              ),
              Expanded(
                child: TextFormField(
                  key: const ValueKey('content'),
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
                  onSaved: (value) {
                    postContent = value.toString();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 26),
        child: FloatingActionButton(
          onPressed: () async {
            print('COMMENT: $postContent');
            _saveForm();
            await Provider.of<PostProvider>(context, listen: false).addNewPost(
              movie: movie,
              postContent: postContent,
              postTitle: postTitle,
              userID: _userId,
              userImage: images[0].imageUrl,
              username: user[0].username,
            );

            widget.callback(true);

            Navigator.of(context).pop();
          },
          child: Icon(
            EneftyIcons.send_2_bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
