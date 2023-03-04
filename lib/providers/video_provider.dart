import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Providers
import '../providers/video.dart';

class VideosProvider with ChangeNotifier {
  List<Video> _videos = [];

  List<Video> get video {
    return [..._videos];
  }

  void loadVideos() {
    _videos = [
      Video(
        id: 'x606y4QWrxo1',
        author: 'currentUser',
        title: 'Ad Astra',
        imageUrl:
            'https://m.media-amazon.com/images/I/813iyI20fKL._AC_SY550_.jpg',
        bannerUrl: 'https://i.ytimg.com/vi/y8CWj85P2cc/maxresdefault.jpg',
        rate: 10,
      ),
      Video(
        author: 'currentUser',
        id: 'vrPk6LB9bjo2',
        title: 'Blade Runner 2049',
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/M/MV5BNzA1Njg4NzYxOV5BMl5BanBnXkFtZTgwODk5NjU3MzI@._V1_.jpg',
        bannerUrl:
            'https://blogs.uai.com.br/opipoqueiro/wp-content/uploads/sites/54/2017/10/Blade-Runner-2049-banner.jpg',
        rate: 10,
      ),
      Video(
        id: 'ilX5hnH8XoI3',
        author: 'currentUser',
        title: 'Ex Machina',
        imageUrl:
            'https://m.media-amazon.com/images/I/61NXaDOlYpL._AC_SX679_.jpg',
        bannerUrl:
            'https://rare-gallery.com/mocahbig/72715-Ex-Machina-HD-Wallpaper.jpg',
        rate: 10,
      ),
      Video(
        id: 'ilX5hnH8XoI4',
        author: 'currentUser',
        title: 'Avatar',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/en/thumb/d/d6/Avatar_%282009_film%29_poster.jpg/220px-Avatar_%282009_film%29_poster.jpg',
        bannerUrl:
            'https://www.beebibelle.com.au/assets/full/78067_3ftx5ft.jpg?20220613141027',
        rate: 10,
      ),
      Video(
        id: 'ilX5hnH8XoI5',
        author: 'currentUser',
        title: 'Interstellar',
        imageUrl:
            'https://m.media-amazon.com/images/I/A1JVqNMI7UL._AC_SL1500_.jpg',
        bannerUrl: 'https://www.esquerda.net/sites/default/files/bg_0.jpg',
        rate: 10,
      ),
      Video(
        id: 'ilX5hnH8XoI6',
        author: 'currentUser',
        title: 'Dune',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/pt/thumb/c/c0/Dune_2020.jpeg/230px-Dune_2020.jpeg',
        bannerUrl:
            'https://www.giantfreakinrobot.com/wp-content/uploads/2021/10/dune-review-scaled.jpg',
        rate: 10,
      ),
    ];

    notifyListeners();
  }
}
