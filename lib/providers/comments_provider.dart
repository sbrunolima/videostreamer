import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Providers
import '../objects/communit_post.dart';
import '../auth_screen/http_exception.dart';

class CommentProvider with ChangeNotifier {
  List<Comments> _comments = [];

  List<Comments> get comments {
    return [..._comments];
  }

  //Load all coments from firebase
  Future<void> loadComments() async {
    try {
      final response = await http.get(url);
      final extracedData =
          await json.decode(response.body) as Map<dynamic, dynamic>;
      final List<Comments> loadedComments = [];

      if (extracedData == null) return;

      extracedData.forEach(
        (commentsID, commentsData) {
          loadedComments.add(
            Comments(
              id: commentsID,
              username: commentsData['username'],
              userImage: commentsData['userImage'],
              userID: commentsData['userID'],
              postID: commentsData['postID'],
              userComment: commentsData['userComment'],
              likes: int.parse(commentsData['likes']),
              dateTime: DateTime.parse(commentsData['dateTime']),
            ),
          );
        },
      );

      _comments = loadedComments.reversed.toList();
      notifyListeners();
      print('COMMENTS: ${_comments[0].username}');
    } catch (error) {
      print('ERRO => $error');
    }
  }

  //Send comment to firebase
  Future<void> sendComment({
    required String postID,
    required String userID,
    required String userImage,
    required String username,
    required String userComment,
  }) async {

    final timestamp = DateTime.now();

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "postID": postID,
            "userImage": userImage,
            "dateTime": timestamp.toIso8601String(),
            "username": username,
            "likes": "0",
            "userComment": userComment,
            "userID": userID,
          },
        ),
      );

      //Create a local comment to refresh the UI
      final newComment = Comments(
        id: json.decode(response.body)['name'],
        postID: postID,
        userImage: userImage,
        dateTime: DateTime.parse(timestamp.toIso8601String()),
        username: username,
        likes: int.parse("0"),
        userComment: userComment,
        userID: userID,
      );

      _comments.add(newComment);
      notifyListeners();
    } catch (error) {
      print('ERRO => $error');
    }
  }

  //delete coments from firebase
  Future<void> deleteComment({required String commentID}) async {

    final existingCommentIndex =
        _comments.indexWhere((comment) => comment.id == commentID);
    var existingPost = _comments[existingCommentIndex];

    _comments.removeAt(existingCommentIndex);
    notifyListeners();

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _comments.insert(existingCommentIndex, existingPost);
      notifyListeners();
      throw HttpException('An error occured deleting the comment!');
    }
  }

  //Delete all COMMENTS from a deleted POST
  Future<void> deletePostComments({required String postID}) async {
    print('postID01 => $postID');
    final commentToDelete =
        _comments.where((comment) => comment.postID == postID).toList();

    for (int i = 0; i < commentToDelete.length; i++) {
      String commentsToDeleteID = commentToDelete[i].id;
      print('commentToDelete => $commentsToDeleteID');


      final existingCommentIndex =
          _comments.indexWhere((comment) => comment.postID == postID);
      var existingComment = _comments[existingCommentIndex];

      _comments.removeAt(existingCommentIndex);
      notifyListeners();

      final response = await http.delete(url);
      if (response.statusCode >= 400) {
        _comments.insert(existingCommentIndex, existingComment);
        notifyListeners();
        throw HttpException('An error occured deleting the comment!');
      }
    }
  }
}
