import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Providers
import '../objects/communit_post.dart';
import '../auth_screen/http_exception.dart';

class ReplyLikeProvider with ChangeNotifier {
  List<LikeReply> _like = [];

  List<LikeReply> get like {
    return [..._like];
  }

  //Load all likes from firebase
  Future<void> loadLikes() async {

    try {
      final response = await http.get(url);
      final extractedData =
          await json.decode(response.body) as Map<dynamic, dynamic>;
      final List<LikeReply> loadedLikes = [];

      if (extractedData == null) return;

      extractedData.forEach(
        (likeID, likeData) {
          loadedLikes.add(
            LikeReply(
              id: likeID,
              userID: likeData['userID'],
              replyID: likeData['replyID'],
              favorite:
                  likeData['favorite'] == null ? false : likeData['favorite'],
            ),
          );
        },
      );

      _like = loadedLikes.toList();
      notifyListeners();
    } catch (error) {
      print('ERRO => $error');
    }
  }

  //Delete likes from firebase
  Future<void> addLike(String userID, String replyID) async {

    final response = await http.post(
      url,
      body: json.encode(
        {
          "userID": userID,
          "replyID": replyID,
          "favorite": true,
        },
      ),
    );
  }

  Future<void> deleteLike(String id) async {

    final existingLikeIndex = _like.indexWhere((like) => like.id == id);
    var existingLike = _like[existingLikeIndex];

    _like.removeAt(existingLikeIndex);
    notifyListeners();

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _like.insert(existingLikeIndex, existingLike);
      notifyListeners();
    }
    existingLike;
  }

  //Delete all likes from an deleted COMMENT from a deleted POST
  Future<void> deleteCommentReplyLikes({required String replyID}) async {
    //print('postID02 => $replyID');
    final likeToDelete =
        _like.where((like) => like.replyID == replyID).toList();
    print('likeLen => ${likeToDelete.length}');

    for (int i = 0; i < likeToDelete.length; i++) {
      //Take the like ID
      String likesToDeleteID = likeToDelete[i].id;
      print('replyID => ${likesToDeleteID}');

      final existingLikeIndex =
          _like.indexWhere((likes) => likes.replyID == replyID);
      var existingComment = _like[existingLikeIndex];

      _like.removeAt(existingLikeIndex);
      notifyListeners();

      final response = await http.delete(url);
      if (response.statusCode >= 400) {
        _like.insert(existingLikeIndex, existingComment);
        notifyListeners();
        throw HttpException('An error occured deleting the comment!');
      }
    }
  }
}
