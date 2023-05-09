import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:jumping_dot/jumping_dot.dart';

//Widgets
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

      //Load all carousels
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
    //Get the device size
    final mediaQuery = MediaQuery.of(context).size;
    //Load all necessary data - Banners
    //-----------------------------------------------------------------------
    final bannerData = Provider.of<CarouselProvider>(context, listen: false);
    final banner = bannerData.banner;
    //-----------------------------------------------------------------------
    //END Load all necessary data - Banners

    //If is empty, sow oading Widget
    //Else, load the carousel
    return banner.isEmpty
        ? loadingData()
        : Column(
            children: [
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: mediaQuery.height - 400,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.15,
                  viewportFraction: 0.9,
                  autoPlayInterval: const Duration(seconds: 10),
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index),
                ),
                itemCount: banner.length,
                itemBuilder: (context, index, realIndex) {
                  final imageUrl = banner[index].coverUrl.toString();
                  final trailerID = banner[index].trailerID.toString();
                  return BannerWidget(imageUrl: imageUrl, trailerID: trailerID);
                },
              ),
              const SizedBox(height: 10),
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
