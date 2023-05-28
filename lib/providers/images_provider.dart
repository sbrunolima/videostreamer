import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Providers
import '../objects/images.dart';

class ImagesProvider with ChangeNotifier {
  List<Images> _images = [];

  List<Images> get images {
    return [..._images];
  }

  //Load all images from firebase
  Future<void> loadProfileImages() async {

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<dynamic, dynamic>;

      if (extractedData == null) return;

      final List<Images> loadedImages = [];

      extractedData.forEach(
        (imageID, imageData) {
          loadedImages.add(
            Images(
              id: imageID,
              imageUrl: imageData['imageUrl'],
            ),
          );
        },
      );

      _images = loadedImages.toList();
      print('VIDEOLEN2 ${_images[0]}');

      notifyListeners();
    } catch (error) {
      print('ERRO => $error');
    }
  }
}
