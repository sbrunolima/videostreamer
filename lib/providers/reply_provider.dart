import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Providers
import '../objects/communit_post.dart';
import '../auth_screen/http_exception.dart';

class ReplyProvider with ChangeNotifier {
  List<Reply> _reply = [];

  List<Reply> get reply {
    return [..._reply];
  }

  //Load replies from firebase
  Future<void> loadReply() async {

    try {
      final response = await http.get(url);
      final extractedData =
          await json.decode(response.body) as Map<dynamic, dynamic>;
      final List<Reply> loadedReply = [];

      if (extractedData == null) return;

      extractedData.forEach(
        (replyID, replyData) {
          loadedReply.add(
            Reply(
              id: replyID,
              username: replyData['username'],
              userImage: replyData['userImage'],
              userID: replyData['userID'],
              commentID: replyData['commentID'],
              userReply: replyData['userReply'],
              dateTime: DateTime.parse(replyData['dateTime']),
            ),
          );
        },
      );

      _reply = loadedReply.reversed.toList();
      notifyListeners();
    } catch (error) {
      print('ERRO => $error');
    }
  }

  //Send replies to firebase
  Future<void> sendReply({
    required String commentID,
    required String userID,
    required String userImage,
    required String username,
    required String userReply,
  }) async {

    final timestamp = DateTime.now();

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "commentID": commentID,
            "userImage": userImage,
            "dateTime": timestamp.toIso8601String(),
            "username": username,
            "userReply": userReply,
            "userID": userID,
          },
        ),
      );

      final newReply = Reply(
        id: json.decode(response.body)['name'],
        commentID: commentID,
        userImage: userImage,
        dateTime: DateTime.parse(timestamp.toIso8601String()),
        username: username,
        userReply: userReply,
        userID: userID,
      );

      _reply.add(newReply);
      notifyListeners();
    } catch (error) {
      print('ERRO => $error');
    }
  }

  //Delete a reply from firebase
  Future<void> deleteReply({required String replyID}) async {

    final existingPostIndex = _reply.indexWhere((post) => post.id == replyID);
    var existingPost = _reply[existingPostIndex];

    _reply.removeAt(existingPostIndex);
    notifyListeners();

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _reply.insert(existingPostIndex, existingPost);
      notifyListeners();
      throw HttpException('An error occured deleting the reply!');
    }
  }

  //Delete all REPLIES from an deleted COMMENT from a deleted POST
  Future<void> deleteReplyComment({required String commentID}) async {
    print('postID03 => $commentID');
    final replyToDelete =
        _reply.where((reply) => reply.commentID == commentID).toList();
    print('replyLen => ${replyToDelete.length}');

    for (int i = 0; i < replyToDelete.length; i++) {
      //Take the like ID
      String replyToDeleteID = replyToDelete[i].id;
      print('replyID => ${replyToDeleteID}');

      final existingCommentReplyIndex =
          _reply.indexWhere((reply) => reply.commentID == commentID);
      var existingReplyComment = _reply[existingCommentReplyIndex];

      _reply.removeAt(existingCommentReplyIndex);
      notifyListeners();

      final response = await http.delete(url);
      if (response.statusCode >= 400) {
        _reply.insert(existingCommentReplyIndex, existingReplyComment);
        notifyListeners();
        throw HttpException('An error occured deleting the comment!');
      }
    }
  }
}
