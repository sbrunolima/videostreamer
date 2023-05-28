import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Providers
import '../objects/communit_post.dart';
import '../auth_screen/http_exception.dart';

class PostProvider with ChangeNotifier {
  List<CommunityPost> _posts = [];

  List<CommunityPost> get posts {
    return [..._posts];
  }

  //Load posts from firebase
  Future<void> loadPosts() async {

    try {
      final response = await http.get(url);
      final extractedData =
          await json.decode(response.body) as Map<dynamic, dynamic>;
      final List<CommunityPost> loadedPosts = [];

      if (extractedData == null) return;

      extractedData.forEach(
        (postsID, postsData) {
          loadedPosts.add(
            CommunityPost(
              id: postsID,
              userID: postsData['userID'],
              username: postsData['username'],
              userImage: postsData['userImage'],
              postTitle: postsData['postTitle'],
              postContent: postsData['postContent'],
              dateTime: DateTime.parse(postsData['dateTime']),
              movie: postsData['movie'],
              likes: int.parse(postsData['likes']),
            ),
          );
        },
      );

      _posts = loadedPosts.reversed.toList();
      print('POSTID ${_posts[0].id}');
      notifyListeners();
    } catch (error) {
      print('ERRO => $error');
    }
  }

  //Add a post on firebase
  Future<void> addNewPost({
    required String movie,
    required String postContent,
    required String postTitle,
    required String userID,
    required String userImage,
    required String username,
  }) async {

    final timestamp = DateTime.now();

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "dateTime": timestamp.toIso8601String(),
            "likes": "0",
            "movie": movie,
            "postContent": postContent,
            "postTitle": postTitle,
            "userID": userID,
            "userImage": userImage,
            "username": username,
          },
        ),
      );

      final newPosts = CommunityPost(
        id: json.decode(response.body)['name'],
        userID: userID,
        username: username,
        userImage: userImage,
        postTitle: postTitle,
        postContent: postContent,
        movie: movie,
        likes: int.parse("0"),
        dateTime: DateTime.parse(timestamp.toIso8601String()),
      );

      _posts.add(newPosts);
      notifyListeners();
    } catch (error) {
      print('ERRO => $error');
    }
  }

  //Delete the post from firebase
  Future<void> deletePost({required String postID}) async {

    final existingPostIndex = _posts.indexWhere((post) => post.id == postID);
    var existingPost = _posts[existingPostIndex];

    _posts.removeAt(existingPostIndex);
    notifyListeners();

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _posts.insert(existingPostIndex, existingPost);
      notifyListeners();
      throw HttpException('An error occured deleting the post!');
    }
  }
}
