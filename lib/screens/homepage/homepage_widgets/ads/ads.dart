import 'package:flutter/material.dart';
import 'dart:async';

class AdvertisementSlider extends StatefulWidget {
  final double width;
  final double height;

  const AdvertisementSlider({
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  _AdvertisementSliderState createState() => _AdvertisementSliderState();
}

class _AdvertisementSliderState extends State<AdvertisementSlider> {
  final PageController _pageController = PageController(viewportFraction: 0.58, initialPage: 1);
  int _currentPage = 1;
  Timer? _timer;

  final List<String> _images = [
    'assets/Ads/Web_development.png',
    'assets/Ads/Social_Media_Management.png',
    'assets/Ads/Customer_service.png', // Placeholder paths for advertisement images
    'assets/Ads/Mobile_app_development.png',
  ];

  List<String> get _extendedImages {
    return [
      _images.last,
      ..._images,
      _images.first,
    ];
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });

    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _extendedImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 1;
        _pageController.jumpToPage(_currentPage);
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _extendedImages.length,
        onPageChanged: (int index) {
          setState(() {
            if (index == _extendedImages.length - 1) {
              _currentPage = 1;
              _pageController.jumpToPage(_currentPage);
            } else if (index == 0) {
              _currentPage = _extendedImages.length - 2;
              _pageController.jumpToPage(_currentPage);
            } else {
              _currentPage = index;
            }
          });
        },
        itemBuilder: (context, index) {
          double scale = (_currentPage == index) ? 1.0 : 0.8;
          double angle = (_currentPage == index) ? 0.0 : 0.1;
          return TweenAnimationBuilder(
            duration: Duration(milliseconds: 300),
            tween: Tween(begin: 0.8, end: scale),
            curve: Curves.ease,
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  _extendedImages[index],
                  fit: BoxFit.cover,
                  width: widget.width,
                  height: widget.height,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
