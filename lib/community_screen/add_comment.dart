import 'package:flutter/material.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:provider/provider.dart';

//Provider
import '../objects/communit_post.dart';
import '../providers/comments_provider.dart';

//Objects
import '../objects/user.dart';

//Widgets
import '../widgets/my_back_icon.dart';
import '../widgets/my_title.dart';

//Add Comment Widget
class AddComment extends StatefulWidget {
  final UserData user;
  final CommunityPost post;

  //Callback function to refresh the page
  final Function(bool) callback;

  AddComment({required this.user, required this.post, required this.callback});

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final _observation = FocusNode();
  final _formKey = GlobalKey<FormState>();

  bool _contiueContent = false;
  var _comment = '';

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
                    _comment = value.toString();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      //The button activate or not if the user enter any data
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
                //Save the formfield
                _saveForm();

                //Access the CommentProvider and send the comment to firebase
                //Using the sendComment function
                await Provider.of<CommentProvider>(context, listen: false)
                    .sendComment(
                  postID: widget.post.id,
                  userID: widget.user.userID,
                  userImage: widget.user.imageUrl,
                  username: widget.user.username,
                  userComment: _comment,
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
