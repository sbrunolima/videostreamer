import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Video with ChangeNotifier {
  final String id;
  final String author;
  final String title;
  final String imageUrl;
  final String bannerUrl;
  final int rate;

  Video({
    required this.id,
    required this.author,
    required this.title,
    required this.imageUrl,
    required this.bannerUrl,
    required this.rate,
  });
}
