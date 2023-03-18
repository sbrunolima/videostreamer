import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:jumping_dot/jumping_dot.dart';

//Providers
import '../providers/video_provider.dart';

//Widgets
import '../widgets/movie_card.dart';
import '../widgets/action_test.dart';
import '../widgets/banner_widget.dart';

//Providers
import '../providers/carousel_provider.dart';

class CarouselWidget extends StatefulWidget {
  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int activeIndex = 0;

  var _isLoading = false;
  var _isInit = true;

  @override
  void initState() {
    super.initState();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<CarouselProvider>(context, listen: false)
          .loadCarousel()
          .then((_) async {
        setState(() {
          setState(() {
            _isLoading = true;
          });
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final imageWidth = MediaQuery.of(context).size.width;
    final bannerData = Provider.of<CarouselProvider>(context, listen: false);
    final banner = bannerData.banner;
    return banner.isEmpty
        ? loadingData()
        : Column(
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
                itemCount: banner.length,
                itemBuilder: (context, index, realIndex) {
                  final imageUrl = banner[index].imageUrl.toString();
                  final trailerID = banner[index].trailerID.toString();
                  return BannerWidget(imageUrl: imageUrl, trailerID: trailerID);
                },
              ),
              const SizedBox(height: 20),
              AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: banner.length,
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

  Widget loadingData() {
    return Container(
      height: 595,
      child: const JumpingDots(
        color: Colors.white54,
        radius: 6,
      ),
    );
  }
}
