import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Video with ChangeNotifier {
  final String id;
  final String author;
  final String title;
  final String trailerURL;
  final String imageUrl;
  final String bannerUrl;
  final String age;
  final String release;
  final String rate;
  final String time;
  final List<String> genre;
  final List<String> castImages;
  final List<String> castNames;
  final List<String> storyline;

  Video({
    required this.id,
    required this.author,
    required this.title,
    required this.trailerURL,
    required this.imageUrl,
    required this.bannerUrl,
    required this.age,
    required this.release,
    required this.rate,
    required this.time,
    required this.genre,
    required this.castImages,
    required this.castNames,
    required this.storyline,
  });
}
