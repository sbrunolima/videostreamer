import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Providers
import '../objects/communit_post.dart';
import '../auth_screen/http_exception.dart';

class PostLikeProvider with ChangeNotifier {
  List<LikePost> _like = [];

  List<LikePost> get like {
    return [..._like];
  }

  //Load all likes from firebase
  Future<void> loadLikes() async {

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<dynamic, dynamic>;
      final List<LikePost> loadedLikes = [];

      if (extractedData == null) return;

      extractedData.forEach(
        (likeID, likeData) {
          loadedLikes.add(
            LikePost(
              id: likeID,
              userID: likeData['userID'],
              postID: likeData['postID'],
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

  //Add likes to firebase
  Future<void> addLike(String userID, String postID) async {

    final response = await http.post(
      url,
      body: json.encode(
        {
          "userID": userID,
          "postID": postID,
          "favorite": true,
        },
      ),
    );
  }

  //Delete likes from firebase
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

  //Delete all LIKES from a deleted POST
  Future<void> deletePostLikes({required String postID}) async {
    print('postID02 => $postID');
    final likeToDelete = _like.where((like) => like.postID == postID).toList();
    print('likeLen => ${likeToDelete.length}');

    for (int i = 0; i < likeToDelete.length; i++) {
      String likeToDeleteID = likeToDelete[i].id;
      print('likeToDelete => $likeToDeleteID');

      final existingCommentIndex =
          _like.indexWhere((comment) => comment.postID == postID);
      var existingComment = _like[existingCommentIndex];

      _like.removeAt(existingCommentIndex);
      notifyListeners();

      final response = await http.delete(url);
      if (response.statusCode >= 400) {
        _like.insert(existingCommentIndex, existingComment);
        notifyListeners();
        throw HttpException('An error occured deleting the comment!');
      }
    }
  }
}
