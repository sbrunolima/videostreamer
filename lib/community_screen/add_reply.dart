import 'package:flutter/material.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:provider/provider.dart';

//Provider
import '../objects/communit_post.dart';
import '../providers/reply_provider.dart';

//Objects
import '../objects/user.dart';

//Widgets
import '../widgets/my_back_icon.dart';
import '../widgets/my_title.dart';

//Add Reply Widget
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
                    _reply = value.toString();
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

                //Access the ReplyProvider and send the comment to firebase
                //Using the sendReply function
                await Provider.of<ReplyProvider>(context, listen: false)
                    .sendReply(
                  commentID: widget.comment.id,
                  userID: widget.user.userID,
                  userImage: widget.user.imageUrl,
                  username: widget.user.username,
                  userReply: _reply,
                );

                //Close the AddCommnent screen
                Navigator.of(context).pop();
              }
            : null,
      ),
    );
  }
}
