import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Provider
import '../providers/post_provider.dart';

//Objects
import '../objects/user.dart';

//Widgets
import '../widgets/my_back_icon.dart';
import '../widgets/my_title.dart';

//Add Post Widget
class AddPost extends StatefulWidget {
  final UserData user;

  //Callback function to refresh the page
  final Function(bool) callback;

  AddPost({required this.user, required this.callback});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _observation = FocusNode();
  final _formKey = GlobalKey<FormState>();

  var _postContent = '';
  var _postTitle = '';
  var _movie = '';

  //Variables user to identify it the user entered all Forms
  bool _contiueTitle = false;
  bool _contiueSubtitle = false;
  bool _contiueContent = false;

  @override
  void dispose() {
    super.dispose();
    _observation.dispose();
  }

  //Save the form field
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
        title: MyTitle(title: 'Add new post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                key: const ValueKey('title'),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Enter a valit title.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) {
                  //Continue only if the user add any comment
                  if (value.toString().length > 0) {
                    setState(() {
                      _contiueTitle = true;
                    });
                  } else {
                    setState(() {
                      _contiueTitle = false;
                    });
                  }
                },
                onSaved: (value) {
                  _postTitle = value.toString();
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                key: const ValueKey('movie'),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Enter a Category or Movie.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Category or Movie',
                ),
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) {
                  //Continue only if the user add any comment
                  if (value.toString().length > 0) {
                    setState(() {
                      _contiueSubtitle = true;
                    });
                  } else {
                    setState(() {
                      _contiueSubtitle = false;
                    });
                  }
                },
                onSaved: (value) {
                  _movie = value.toString();
                },
              ),
              Expanded(
                child: TextFormField(
                  key: const ValueKey('content'),
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
                    //Continue only if the user add any comment
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
                    _postContent = value.toString();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      //The button activate or not if the user enter any data
      floatingActionButton: FloatingActionButton(
        backgroundColor: (_contiueTitle && _contiueSubtitle && _contiueContent)
            ? Colors.greenAccent
            : Colors.grey.shade600,
        child: Icon(
          EneftyIcons.send_3_bold,
          color: (_contiueTitle && _contiueSubtitle && _contiueContent)
              ? Colors.white
              : Colors.grey.shade700,
          size: 30,
        ),
        onPressed: (_contiueTitle && _contiueSubtitle && _contiueContent)
            ? () async {
                //Save the formfield
                _saveForm();

                //Access the PostProvider and send the comment to firebase
                //Using the addNewPost function
                await Provider.of<PostProvider>(context, listen: false)
                    .addNewPost(
                  movie: _movie,
                  postContent: _postContent,
                  postTitle: _postTitle,
                  userID: widget.user.userID,
                  userImage: widget.user.imageUrl,
                  username: widget.user.username,
                );

                //Return the BOOL value after finish the adding
                widget.callback(true);

                //Close the AddCommnent screen
                Navigator.of(context).pop();
              }
            : null,
      ),
    );
  }
}
