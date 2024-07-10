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
  final PageController _pageController = PageController(viewportFraction: 0.5);
  int _currentPage = 0;
  Timer? _timer;

  final List<String> _images = [
    'assets/Ads/Web_development.png',
    'assets/Ads/Social_Media_Management.png',
    'assets/Ads/Customer_service.png', // Placeholder paths for advertisement images
    'assets/Ads/Mobile_app_development.png',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _images.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
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
        itemCount: _images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                _images[index],
                fit: BoxFit.cover,
                width: widget.width,
                height: widget.height,
              ),
            ),
          );
        },
      ),
    );
  }
}
