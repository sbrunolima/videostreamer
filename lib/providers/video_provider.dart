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
        age: '14',
        release: '2019',
        rate: '8.5',
        time: '2h 4m',
        genre: 'Adventure',
        castImages: [
          'https://images.mubicdn.net/images/cast_member/2552/cache-207-1524922850/image-w856.jpg',
          'https://m.media-amazon.com/images/M/MV5BMTkyNjc4MDc0OV5BMl5BanBnXkFtZTcwOTc5OTUwOQ@@._V1_.jpg',
          'https://br.web.img3.acsta.net/r_1280_720/medias/nmedia/18/81/99/55/20201425.jpg',
          'https://br.web.img3.acsta.net/pictures/20/01/09/01/28/3536010.jpg',
          'https://fr.web.img6.acsta.net/pictures/19/08/30/10/22/5000319.jpg',
          'https://br.web.img2.acsta.net/pictures/19/03/08/22/10/0741995.jpg',
          'https://br.web.img2.acsta.net/pictures/19/03/08/22/10/0741995.jpg ',
          'https://br.web.img2.acsta.net/pictures/17/04/07/12/28/474620.jpg',
          'https://images.mubicdn.net/images/cast_member/116403/cache-243949-1528785046/image-w856.jpg',
          'https://flxt.tmsimg.com/assets/68350_v9_bb.jpg',
          'https://flxt.tmsimg.com/assets/71707_v9_bb.jpg',
          'https://static.wikia.nocookie.net/howtogetawaywithmurderabc/images/d/dd/Elisa_Perry.png',
          'https://images.mubicdn.net/images/cast_member/39551/cache-447934-1561569068/image-w856.jpg',
          'https://images.mubicdn.net/images/cast_member/29994/cache-568341-1595262840/image-w856.jpg',
          'https://images.mubicdn.net/images/cast_member/37371/cache-244674-1502088093/image-w856.jpg',
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
          'John Ortiz',
          'Loren Dean',
          'Elisa Perry',
          'Ravi Kapoor',
          'Donnie Keshawarz',
          'John Finn',
        ],
        storyline: [
          'Astronaut Roy McBride undertakes a mission across an unforgiving solar system to uncover the truth about his missing father and his doomed expedition that now, 30 years later, threatens the universe.'
        ],
      ),
      Video(
        author: 'currentUser',
        id: 'vrPk6LB9bjo2',
        title: 'Blade Runner 2049',
        trailerURL: 'assets/trailers/bladerunne2049.mp4',
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/M/MV5BNzA1Njg4NzYxOV5BMl5BanBnXkFtZTgwODk5NjU3MzI@._V1_.jpg',
        bannerUrl:
            'https://www.hdwallpapers.in/download/ryan_gosling_blade_runner_2049_hd-1080x1920.jpg',
        age: '14',
        release: '2019',
        rate: '8.5',
        time: '2h 4m',
        genre: 'Action',
        castImages: [
          'https://media.fstatic.com/lhwC16sJLL8yuSeFFX9GCMKhi-k=/full-fit-in/290x478/filters:format(webp)/media/artists/avatar/2016/12/ryan-gosling_a106376_pXORbNR.jpg',
          'https://static.wikia.nocookie.net/ptstarwars/images/d/d4/Harrison.jpg/revision/latest?cb=20061120214705',
          'https://cdna.artstation.com/p/assets/images/images/045/088/954/large/xie-boli-8.jpg?1641899042',
          'https://br.web.img2.acsta.net/pictures/19/10/30/17/02/0678166.jpg',
          'https://media.fstatic.com/cejoFyGSpmlb24YIGokDOArqS5c=/full-fit-in/290x478/filters:format(webp)/media/artists/avatar/2018/05/mackenzie-davis_a280208.jpg',
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Jared_Leto_by_Gage_Skidmore.jpg/800px-Jared_Leto_by_Gage_Skidmore.jpg',
          'https://images.mubicdn.net/images/cast_member/22303/cache-2934-1543703714/image-w856.jpg',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoMi020Rj8HJiMdssldLTB3qTwwsPOg4aAlA&usqp=CAU',
          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Carla_Juri%2C_Laura_Birn_%282%29_%28cropped_-_Juri%29.jpg/250px-Carla_Juri%2C_Laura_Birn_%282%29_%28cropped_-_Juri%29.jpg',
        ],
        castNames: [
          'Ryan Gosling',
          'Harrison Ford',
          'Ana de Armas',
          'Sylvia Hoeks',
          'Mackenzie Davis',
          'Mackenzie Davis',
          'Robin Wright',
          'Dave Bautista',
          'Carla Juri',
        ],
        storyline: [
          "Young Blade Runner K's discovery of a long-buried secret leads him to track down former Blade Runner Rick Deckard, who's been missing for thirty years."
        ],
      ),
      Video(
        id: 'ilX5hnH8XoI3',
        author: 'currentUser',
        title: 'Ex Machina',
        trailerURL: 'assets/trailers/exmachina.mp4',
        imageUrl:
            'https://m.media-amazon.com/images/I/61NXaDOlYpL._AC_SX679_.jpg',
        bannerUrl: 'https://wallpapercave.com/wp/wp2236201.jpg',
        age: '14',
        release: '2019',
        rate: '8.5',
        time: '2h 4m',
        genre: 'SciFi',
        castImages: [],
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
        storyline: [
          'A young programmer is selected to participate in a ground-breaking experiment in synthetic intelligence by evaluating the human qualities of a highly advanced humanoid A.I.'
        ],
      ),
      Video(
        id: 'ilX5hnH8XoI4',
        author: 'currentUser',
        title: 'Avatar',
        trailerURL: 'assets/trailers/avatar.mp4',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/en/thumb/d/d6/Avatar_%282009_film%29_poster.jpg/220px-Avatar_%282009_film%29_poster.jpg',
        bannerUrl: 'https://wallpaperaccess.com/full/1816364.jpg',
        age: '14',
        release: '2019',
        rate: '8.5',
        time: '2h 4m',
        genre: 'Action',
        castImages: [
          'https://media.fstatic.com/lhwC16sJLL8yuSeFFX9GCMKhi-k=/full-fit-in/290x478/filters:format(webp)/media/artists/avatar/2016/12/ryan-gosling_a106376_pXORbNR.jpg',
          'https://static.wikia.nocookie.net/ptstarwars/images/d/d4/Harrison.jpg/revision/latest?cb=20061120214705',
          'https://cdna.artstation.com/p/assets/images/images/045/088/954/large/xie-boli-8.jpg?1641899042',
          'https://br.web.img2.acsta.net/pictures/19/10/30/17/02/0678166.jpg',
          'https://media.fstatic.com/cejoFyGSpmlb24YIGokDOArqS5c=/full-fit-in/290x478/filters:format(webp)/media/artists/avatar/2018/05/mackenzie-davis_a280208.jpg',
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Jared_Leto_by_Gage_Skidmore.jpg/800px-Jared_Leto_by_Gage_Skidmore.jpg',
          'https://images.mubicdn.net/images/cast_member/22303/cache-2934-1543703714/image-w856.jpg',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoMi020Rj8HJiMdssldLTB3qTwwsPOg4aAlA&usqp=CAU',
          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Carla_Juri%2C_Laura_Birn_%282%29_%28cropped_-_Juri%29.jpg/250px-Carla_Juri%2C_Laura_Birn_%282%29_%28cropped_-_Juri%29.jpg',
        ],
        castNames: [
          'Ryan Gosling',
          'Harrison Ford',
          'Ana de Armas',
          'Sylvia Hoeks',
          'Mackenzie Davis',
          'Mackenzie Davis',
          'Robin Wright',
          'Dave Bautista',
          'Carla Juri',
        ],
        storyline: [
          'A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.'
        ],
      ),
      Video(
        id: 'ilX5hnH8XoI5',
        author: 'currentUser',
        title: 'Interstellar',
        trailerURL: 'assets/trailers/interstellar.mp4',
        imageUrl:
            'https://m.media-amazon.com/images/I/A1JVqNMI7UL._AC_SL1500_.jpg',
        bannerUrl:
            'https://media.idownloadblog.com/wp-content/uploads/2014/12/interstellar-sea-film-space-art-34-iphone6-plus-wallpaper.jpg',
        age: '14',
        release: '2019',
        rate: '8.5',
        time: '2h 4m',
        genre: 'SciFi',
        castImages: [],
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
        storyline: [
          "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival."
        ],
      ),
      Video(
        id: 'ilX5hnH8XoI6',
        author: 'currentUser',
        title: 'Dune',
        trailerURL: 'assets/trailers/dune.mp4',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/pt/thumb/c/c0/Dune_2020.jpeg/230px-Dune_2020.jpeg',
        bannerUrl:
            'https://coolhdwall.com/storage/202106/dune-movie-2021-cast-and-characters-4k-phone-wallpaper-2160x3840.jpg',
        age: '14',
        release: '2019',
        rate: '8.5',
        time: '2h 4m',
        genre: 'Action',
        castImages: [],
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
        storyline: [
          "A noble family becomes embroiled in a war for control over the galaxy's most valuable asset while its heir becomes troubled by visions of a dark future."
        ],
      ),
      Video(
        id: 'ilX5hnH8XoI7',
        author: 'currentUser',
        title: 'Avatar: The Way of Water',
        trailerURL: '',
        imageUrl:
            'https://a-static.mlcdn.com.br/1500x1500/poster-cartaz-avatar-2-o-caminho-da-agua-a-pop-arte-poster/poparteskins2/15983151125/05b13cd9c00028a453c58a879eceb94e.jpeg',
        bannerUrl:
            'https://4kwallpapers.com/images/wallpapers/avatar-the-way-of-water-avatar-2-2022-movies-sam-2732x2732-8963.jpg',
        age: '13',
        release: '2022',
        rate: '8.5',
        time: '3h 12m',
        genre: 'Action',
        castImages: [],
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
        storyline: [
          "Jake Sully lives with his newfound family formed on the extrasolar moon Pandora. Once a familiar threat returns to finish what was previously started, Jake must work with Neytiri and the army of the Na'vi race to protect their home.",
        ],
      ),
      Video(
        id: 'ilX5hnH8XoI8',
        author: 'currentUser',
        title: 'Top Gun: Maverick',
        trailerURL: '',
        imageUrl:
            'https://play-lh.googleusercontent.com/oymP-vT3PYv9lSIlJQ8Mz6j10gQiCCxh65JJR0rPGQfk6zlDNVvh4kkq3YQh6g06XdDwqYit0MRaLPF22A',
        bannerUrl:
            'https://d2s94cyhu2tzlj.cloudfront.net/assets/photos/2022/top-gun-maverick-the-need-for-speed-continues/_articlePhotoFull/top-gun-maverick-ver5-xlg-2-1.jpg?mtime=20220524091657',
        age: '13',
        release: '2022',
        rate: '8.3',
        time: '2h 10m',
        genre: 'Action',
        castImages: [],
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
        storyline: [
          "After thirty years, Maverick is still pushing the envelope as a top naval aviator, but must confront ghosts of his past when he leads TOP GUN's elite graduates on a mission that demands the ultimate sacrifice from those chosen to fly it.",
        ],
      ),
      Video(
        id: 'ilX5hnH8XoI9',
        author: 'currentUser',
        title: 'Ant-Man and the Wasp: Quantumania',
        trailerURL: '',
        imageUrl:
            'https://lumiere-a.akamaihd.net/v1/images/p_antmanquantumania_update_1006_122aeffe.jpeg?region=0%2C0%2C540%2C810',
        bannerUrl:
            'https://images.news18.com/ibnlive/uploads/2023/02/paul-rudd-ant-man-3-1.jpg',
        age: '13',
        release: '2022',
        rate: '6.5',
        time: '2h 4m',
        genre: 'Action',
        castImages: [],
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
        storyline: [
          "Scott Lang and Hope Van Dyne, along with Hank Pym and Janet Van Dyne, explore the Quantum Realm, where they interact with strange creatures and embark on an adventure that goes beyond the limits of what they thought was possible.",
        ],
      ),
      Video(
        id: 'ilX5hnH8XoI10',
        author: 'currentUser',
        title: 'M3GAN',
        trailerURL: '',
        imageUrl:
            'https://images.fandango.com/ImageRenderer/820/0/redesign/static/img/default_poster.png/0/images/masterrepository/fandango/229737/382738id1c_M3GAN_BusShelter_48x70_RGB.jpg',
        bannerUrl:
            'https://pittnews.com/wp-content/uploads/2023/01/C_MeganMovie_Via.png',
        age: '13',
        release: '2022',
        rate: '6.4',
        time: '1h 42m',
        genre: 'Horror',
        castImages: [],
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
        storyline: [
          "A robotics engineer at a toy company builds a life-like doll that begins to take on a life of its own.",
        ],
      ),
      Video(
        id: 'ilX5hnH8XoI11',
        author: 'currentUser',
        title: 'Bullet Train',
        trailerURL: '',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/pt/0/08/Bullet_train_filme.jpg',
        bannerUrl:
            'https://d1fmx1rbmqrxrr.cloudfront.net/cnet/optim/i/edit/2022/07/bullet%20train%20critique%20big__w770.jpg',
        age: 'R',
        release: '2022',
        rate: '7.3',
        time: '2h 7m',
        genre: 'Comedy',
        castImages: [],
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
        storyline: [
          "Five assassins aboard a swiftly-moving bullet train find out that their missions have something in common.",
        ],
      ),
    ];

    notifyListeners();
  }
}
