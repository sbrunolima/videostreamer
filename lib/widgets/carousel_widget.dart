import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//Providers
import '../providers/video_provider.dart';

//Widgets
import '../widgets/movie_card.dart';
import '../widgets/action_test.dart';
import '../widgets/banner_widget.dart';

class CarouselWidget extends StatefulWidget {
  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int activeIndex = 0;

  final homeBanner = [
    BannerWidget(
      imageUrl:
          'https://cdn.shopify.com/s/files/1/0549/5835/8762/products/V_370_ac01b2a1-e5fc-4451-9930-c6d67055284c.jpg?v=1641650628',
      videoID: 'ilX5hnH8XoI7',
    ),
    BannerWidget(
      imageUrl: 'https://wallpapercave.com/wp/wp11284455.jpg',
      videoID: 'ilX5hnH8XoI8',
    ),
    BannerWidget(
      imageUrl:
          'https://preview.redd.it/new-poster-for-ant-man-and-the-wasp-quantumania-v0-we8qt3bx7eha1.jpg?auto=webp&s=28c18ecebbfa65864a427a5d397fd055d96063a8',
      videoID: 'ilX5hnH8XoI9',
    ),
    BannerWidget(
      imageUrl:
          'https://images.fandango.com/ImageRenderer/820/0/redesign/static/img/default_poster.png/0/images/masterrepository/fandango/229737/382738id1c_M3GAN_BusShelter_48x70_RGB.jpg',
      videoID: 'ilX5hnH8XoI10',
    ),
    BannerWidget(
      imageUrl:
          'https://fr.web.img2.acsta.net/pictures/22/07/13/11/36/3514892.jpg',
      videoID: 'ilX5hnH8XoI11',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            height: 550,
            autoPlay: true,
            viewportFraction: 1,
            autoPlayInterval: const Duration(seconds: 20),
            onPageChanged: (index, reason) =>
                setState(() => activeIndex = index),
          ),
          itemCount: homeBanner.length,
          itemBuilder: (context, index, realIndex) {
            return homeBanner[index];
          },
        ),
        const SizedBox(height: 20),
        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: homeBanner.length,
          effect: const SlideEffect(
            dotWidth: 8,
            dotHeight: 8,
            activeDotColor: Colors.white,
            dotColor: Colors.white30,
            spacing: 17,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
