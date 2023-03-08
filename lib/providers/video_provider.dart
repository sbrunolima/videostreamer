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
        trailerURL: 'assets/trailers/adastra.mp4',
        imageUrl:
            'https://m.media-amazon.com/images/I/813iyI20fKL._AC_SY550_.jpg',
        bannerUrl:
            'https://w0.peakpx.com/wallpaper/227/724/HD-wallpaper-ad-astra-2019-movie.jpg',
        age: '12+',
        rate: '8.5',
        genre: [
          'Adventure',
          'Drama',
          'Mistery',
        ],
        castImages: [
          'https://images.mubicdn.net/images/cast_member/2552/cache-207-1524922850/image-w856.jpg?size=800x',
          'https://m.media-amazon.com/images/M/MV5BMTkyNjc4MDc0OV5BMl5BanBnXkFtZTcwOTc5OTUwOQ@@._V1_.jpg',
          'https://musicimage.xboxlive.com/catalog/video.contributor.a92f1200-0200-11db-89ca-0019b92a3933/image?locale=pt-br&target=circle',
          'https://br.web.img3.acsta.net/pictures/20/01/09/01/28/3536010.jpg',
          'https://images.mubicdn.net/images/cast_member/5813/cache-3530-1614805828/image-w856.jpg',
          'https://images.mubicdn.net/images/cast_member/676664/cache-474451-1569826144/image-w856.jpg?size=800x',
          'https://www.rollingstone.com/wp-content/uploads/2023/01/GettyImages-1246264675.jpg',
          'https://br.web.img2.acsta.net/pictures/17/04/07/12/28/474620.jpg',
          'https://musicimage.xboxlive.com/catalog/video.contributor.21016500-0200-11db-89ca-0019b92a3933/image?locale=pt-br&target=circle',
        ],
        castNames: [
          'Brad Pitt',
          'Tommy Lee Jones',
          'Donald Sutherland',
          'Ruth Negga',
          'Liv Tyler',
          'Kayla Adams',
          'Natasha Lyonne',
          'Kimberly Elise',
          'Greg Bryk',
        ],
      ),
      Video(
        author: 'currentUser',
        id: 'vrPk6LB9bjo2',
        title: 'Blade Runner 2049',
        trailerURL: '',
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/M/MV5BNzA1Njg4NzYxOV5BMl5BanBnXkFtZTgwODk5NjU3MzI@._V1_.jpg',
        bannerUrl:
            'https://www.hdwallpapers.in/download/ryan_gosling_blade_runner_2049_hd-1080x1920.jpg',
        age: '12+',
        rate: '8.5',
        genre: [
          'Action',
          'Drama',
          'Mistery',
        ],
        castImages: [
          'https://images.mubicdn.net/images/cast_member/2552/cache-207-1524922850/image-w856.jpg?size=800x',
          'https://m.media-amazon.com/images/M/MV5BMTkyNjc4MDc0OV5BMl5BanBnXkFtZTcwOTc5OTUwOQ@@._V1_.jpg',
          'https://musicimage.xboxlive.com/catalog/video.contributor.a92f1200-0200-11db-89ca-0019b92a3933/image?locale=pt-br&target=circle',
          'https://br.web.img3.acsta.net/pictures/20/01/09/01/28/3536010.jpg',
          'https://images.mubicdn.net/images/cast_member/5813/cache-3530-1614805828/image-w856.jpg',
          'https://images.mubicdn.net/images/cast_member/676664/cache-474451-1569826144/image-w856.jpg?size=800x',
          'https://www.rollingstone.com/wp-content/uploads/2023/01/GettyImages-1246264675.jpg',
          'https://br.web.img2.acsta.net/pictures/17/04/07/12/28/474620.jpg',
          'https://musicimage.xboxlive.com/catalog/video.contributor.21016500-0200-11db-89ca-0019b92a3933/image?locale=pt-br&target=circle',
        ],
        castNames: [
          'Brad Pitt',
          'Tommy Lee Jones',
          'Donald Sutherland',
          'Ruth Negga',
          'Liv Tyler',
          'Kayla Adams',
          'Natasha Lyonne',
          'Kimberly Elise',
          'Greg Bryk',
        ],
      ),
      Video(
        id: 'ilX5hnH8XoI3',
        author: 'currentUser',
        title: 'Ex Machina',
        trailerURL: '',
        imageUrl:
            'https://m.media-amazon.com/images/I/61NXaDOlYpL._AC_SX679_.jpg',
        bannerUrl: 'https://wallpapercave.com/wp/wp2236201.jpg',
        age: '12+',
        rate: '8.5',
        genre: [
          'Thriller',
          'Drama',
          'SciFi',
        ],
        castImages: [
          'https://images.mubicdn.net/images/cast_member/2552/cache-207-1524922850/image-w856.jpg?size=800x',
          'https://m.media-amazon.com/images/M/MV5BMTkyNjc4MDc0OV5BMl5BanBnXkFtZTcwOTc5OTUwOQ@@._V1_.jpg',
          'https://musicimage.xboxlive.com/catalog/video.contributor.a92f1200-0200-11db-89ca-0019b92a3933/image?locale=pt-br&target=circle',
          'https://br.web.img3.acsta.net/pictures/20/01/09/01/28/3536010.jpg',
          'https://images.mubicdn.net/images/cast_member/5813/cache-3530-1614805828/image-w856.jpg',
          'https://images.mubicdn.net/images/cast_member/676664/cache-474451-1569826144/image-w856.jpg?size=800x',
          'https://www.rollingstone.com/wp-content/uploads/2023/01/GettyImages-1246264675.jpg',
          'https://br.web.img2.acsta.net/pictures/17/04/07/12/28/474620.jpg',
          'https://musicimage.xboxlive.com/catalog/video.contributor.21016500-0200-11db-89ca-0019b92a3933/image?locale=pt-br&target=circle',
        ],
        castNames: [
          'Brad Pitt',
          'Tommy Lee Jones',
          'Donald Sutherland',
          'Ruth Negga',
          'Liv Tyler',
          'Kayla Adams',
          'Natasha Lyonne',
          'Kimberly Elise',
          'Greg Bryk',
        ],
      ),
      Video(
        id: 'ilX5hnH8XoI4',
        author: 'currentUser',
        title: 'Avatar',
        trailerURL: '',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/en/thumb/d/d6/Avatar_%282009_film%29_poster.jpg/220px-Avatar_%282009_film%29_poster.jpg',
        bannerUrl: 'https://wallpaperaccess.com/full/1816364.jpg',
        age: '12+',
        rate: '8.5',
        genre: [
          'Adventure',
          'Action',
          'Fantasy',
        ],
        castImages: [
          'https://images.mubicdn.net/images/cast_member/2552/cache-207-1524922850/image-w856.jpg?size=800x',
          'https://m.media-amazon.com/images/M/MV5BMTkyNjc4MDc0OV5BMl5BanBnXkFtZTcwOTc5OTUwOQ@@._V1_.jpg',
          'https://musicimage.xboxlive.com/catalog/video.contributor.a92f1200-0200-11db-89ca-0019b92a3933/image?locale=pt-br&target=circle',
          'https://br.web.img3.acsta.net/pictures/20/01/09/01/28/3536010.jpg',
          'https://images.mubicdn.net/images/cast_member/5813/cache-3530-1614805828/image-w856.jpg',
          'https://images.mubicdn.net/images/cast_member/676664/cache-474451-1569826144/image-w856.jpg?size=800x',
          'https://www.rollingstone.com/wp-content/uploads/2023/01/GettyImages-1246264675.jpg',
          'https://br.web.img2.acsta.net/pictures/17/04/07/12/28/474620.jpg',
          'https://musicimage.xboxlive.com/catalog/video.contributor.21016500-0200-11db-89ca-0019b92a3933/image?locale=pt-br&target=circle',
        ],
        castNames: [
          'Brad Pitt',
          'Tommy Lee Jones',
          'Donald Sutherland',
          'Ruth Negga',
          'Liv Tyler',
          'Kayla Adams',
          'Natasha Lyonne',
          'Kimberly Elise',
          'Greg Bryk',
        ],
      ),
      Video(
        id: 'ilX5hnH8XoI5',
        author: 'currentUser',
        title: 'Interstellar',
        trailerURL: '',
        imageUrl:
            'https://m.media-amazon.com/images/I/A1JVqNMI7UL._AC_SL1500_.jpg',
        bannerUrl:
            'https://media.idownloadblog.com/wp-content/uploads/2014/12/interstellar-sea-film-space-art-34-iphone6-plus-wallpaper.jpg',
        age: '12+',
        rate: '8.5',
        genre: [
          'Adventure',
          'Drama',
          'SciFi',
        ],
        castImages: [
          'https://images.mubicdn.net/images/cast_member/2552/cache-207-1524922850/image-w856.jpg?size=800x',
          'https://m.media-amazon.com/images/M/MV5BMTkyNjc4MDc0OV5BMl5BanBnXkFtZTcwOTc5OTUwOQ@@._V1_.jpg',
          'https://musicimage.xboxlive.com/catalog/video.contributor.a92f1200-0200-11db-89ca-0019b92a3933/image?locale=pt-br&target=circle',
          'https://br.web.img3.acsta.net/pictures/20/01/09/01/28/3536010.jpg',
          'https://images.mubicdn.net/images/cast_member/5813/cache-3530-1614805828/image-w856.jpg',
          'https://images.mubicdn.net/images/cast_member/676664/cache-474451-1569826144/image-w856.jpg?size=800x',
          'https://www.rollingstone.com/wp-content/uploads/2023/01/GettyImages-1246264675.jpg',
          'https://br.web.img2.acsta.net/pictures/17/04/07/12/28/474620.jpg',
          'https://musicimage.xboxlive.com/catalog/video.contributor.21016500-0200-11db-89ca-0019b92a3933/image?locale=pt-br&target=circle',
        ],
        castNames: [
          'Brad Pitt',
          'Tommy Lee Jones',
          'Donald Sutherland',
          'Ruth Negga',
          'Liv Tyler',
          'Kayla Adams',
          'Natasha Lyonne',
          'Kimberly Elise',
          'Greg Bryk',
        ],
      ),
      Video(
        id: 'ilX5hnH8XoI6',
        author: 'currentUser',
        title: 'Dune',
        trailerURL: '',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/pt/thumb/c/c0/Dune_2020.jpeg/230px-Dune_2020.jpeg',
        bannerUrl:
            'https://coolhdwall.com/storage/202106/dune-movie-2021-cast-and-characters-4k-phone-wallpaper-2160x3840.jpg',
        age: '12+',
        rate: '8.5',
        genre: [
          'Adventure',
          'Drama',
          'Action',
        ],
        castImages: [
          'https://images.mubicdn.net/images/cast_member/2552/cache-207-1524922850/image-w856.jpg?size=800x',
          'https://m.media-amazon.com/images/M/MV5BMTkyNjc4MDc0OV5BMl5BanBnXkFtZTcwOTc5OTUwOQ@@._V1_.jpg',
          'https://musicimage.xboxlive.com/catalog/video.contributor.a92f1200-0200-11db-89ca-0019b92a3933/image?locale=pt-br&target=circle',
          'https://br.web.img3.acsta.net/pictures/20/01/09/01/28/3536010.jpg',
          'https://images.mubicdn.net/images/cast_member/5813/cache-3530-1614805828/image-w856.jpg',
          'https://images.mubicdn.net/images/cast_member/676664/cache-474451-1569826144/image-w856.jpg?size=800x',
          'https://www.rollingstone.com/wp-content/uploads/2023/01/GettyImages-1246264675.jpg',
          'https://br.web.img2.acsta.net/pictures/17/04/07/12/28/474620.jpg',
          'https://musicimage.xboxlive.com/catalog/video.contributor.21016500-0200-11db-89ca-0019b92a3933/image?locale=pt-br&target=circle',
        ],
        castNames: [
          'Brad Pitt',
          'Tommy Lee Jones',
          'Donald Sutherland',
          'Ruth Negga',
          'Liv Tyler',
          'Kayla Adams',
          'Natasha Lyonne',
          'Kimberly Elise',
          'Greg Bryk',
        ],
      ),
    ];

    notifyListeners();
  }
}
