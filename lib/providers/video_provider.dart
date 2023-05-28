import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Providers
import '../objects/video.dart';

class VideosProvider with ChangeNotifier {
  List<Video> _videos = [];
  List<Video> _findedVideo = [];

  List<Video> get video {
    return [..._videos];
  }

  List<Video> get findedVideo {
    return [..._findedVideo];
  }

  //Load all videos from firebase
  Future<void> loadVideos() async {

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) return;

      final List<Video> loadedVideos = [];

      extractedData.forEach(
        (videoID, videoData) {
          loadedVideos.add(
            Video(
              id: videoData['id'],
              director: List.from(videoData['director']),
              title: videoData['title'],
              trailerURL: videoData['trailerURL'],
              coverUrl: videoData['coverUrl'],
              bannerUrl: videoData['bannerUrl'],
              age: videoData['age'],
              release: videoData['release'],
              rate: videoData['rate'],
              time: videoData['time'],
              genre: List.from(videoData['genre']),
              castNames: List.from(videoData['castNames']),
              storyline: List.from(videoData['storyline']),
            ),
          );
        },
      );

      _videos = loadedVideos.toList();
      notifyListeners();
    } catch (error) {
      print('ERRO => $error');
    }
  }

  //Find a video on firebase
  Future<void> findVideo(String query) async {

    try {
      final response = await http.get(url);
      final extractedData =
          await json.decode(response.body) as Map<dynamic, dynamic>;
      final List<Video> videoFinded = [];

      if (extractedData == null) return;

      extractedData.forEach((videoID, videoData) {
        if (videoData['title']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase())) {
          videoFinded.add(
            Video(
              id: videoData['id'],
              director: List.from(videoData['director']),
              title: videoData['title'],
              trailerURL: videoData['trailerURL'],
              coverUrl: videoData['coverUrl'],
              bannerUrl: videoData['bannerUrl'],
              age: videoData['age'],
              release: videoData['release'],
              rate: videoData['rate'],
              time: videoData['time'],
              genre: List.from(videoData['genre']),
              castNames: List.from(videoData['castNames']),
              storyline: List.from(videoData['storyline']),
            ),
          );
        }
      });

      _findedVideo = videoFinded.toList();
      notifyListeners();
    } catch (error) {
      print('ERRO => $error');
    }
  }
}
