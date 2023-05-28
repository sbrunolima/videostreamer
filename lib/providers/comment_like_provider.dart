import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Providers
import '../objects/communit_post.dart';
import '../auth_screen/http_exception.dart';

class CommentLikeProvider with ChangeNotifier {
  List<LikeComment> _like = [];

  List<LikeComment> get like {
    return [..._like];
  }

  //Load all Likes itens from firebase
  Future<void> loadLikes() async {

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<dynamic, dynamic>;
      final List<LikeComment> loadedLikes = [];

      if (extractedData == null) return;

      extractedData.forEach(
        (likeID, likeData) {
          loadedLikes.add(
            LikeComment(
              id: likeID,
              userID: likeData['userID'],
              commentID: likeData['commentID'],
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

  //Add Likes itens to firebase
  Future<void> addLike(String userID, String commentID) async {

    final response = await http.post(
      url,
      body: json.encode(
        {
          "userID": userID,
          "commentID": commentID,
          "favorite": true,
        },
      ),
    );
  }

  //Delete Likes itens from firebase
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
  Future<void> deletePostCommentLikes({required String commentID}) async {
    print('postID02 => $commentID');
    final likeToDelete =
        _like.where((like) => like.commentID == commentID).toList();
    print('likeLen => ${likeToDelete.length}');

    for (int i = 0; i < likeToDelete.length; i++) {
      //Take the like ID
      String likesToDeleteID = likeToDelete[i].id;

      final existingLikeIndex =
          _like.indexWhere((likes) => likes.commentID == commentID);
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
