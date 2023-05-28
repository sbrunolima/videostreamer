import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Provider
import '../objects/carousel_banner.dart';

class CarouselProvider with ChangeNotifier {
  List<CarouselBanner> _banner = [];

  List<CarouselBanner> get banner {
    return [..._banner];
  }

  //Load all Carousel itens from firebase
  Future<void> loadCarousel() async {

    try {
      final response = await http.get(url);
      final extractedData =
          await json.decode(response.body) as Map<dynamic, dynamic>;
      final List<CarouselBanner> loadedBanner = [];

      if (extractedData == null) return;

      extractedData.forEach(
        (bannerID, bannerData) {
          loadedBanner.add(
            CarouselBanner(
              id: bannerID,
              coverUrl: bannerData['coverUrl'],
              trailerID: bannerData['trailerID'],
            ),
          );
        },
      );

      _banner = loadedBanner.toList();
      notifyListeners();
    } catch (error) {
      print('ERRO => $error');
    }
  }
}
