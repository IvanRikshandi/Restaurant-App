import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/homepage/utils/carousel_data.dart';

class Carousel extends StatefulWidget {
  const Carousel({
    super.key,
  });

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return _landscapeMode();
    } else {
      return _portraitMode();
    }
  }

  Column _portraitMode() {
    return Column(
      children: [
        Center(
          child: CarouselSlider.builder(
              itemCount: carouselImgUrlsmall.length,
              itemBuilder: (context, idx, realIndex) {
                final ads = carouselImgUrlsmall[idx];
                return SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(ads),
                  ),
                );
              },
              options: CarouselOptions(
                height: 92,
                autoPlay: true,
                autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                enlargeCenterPage: true,
                enlargeFactor: 0.1,
                viewportFraction: 1,
                aspectRatio: 16 / 9,
              )),
        ),
      ],
    );
  }

  Column _landscapeMode() {
    return Column(
      children: [
        Center(
          child: CarouselSlider.builder(
              itemCount: carouselImgUrllarge.length,
              itemBuilder: (context, idx, realIndex) {
                final ads = carouselImgUrllarge[idx];
                return SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(ads),
                  ),
                );
              },
              options: CarouselOptions(
                height: 140,
                autoPlay: true,
                autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                enlargeCenterPage: true,
                enlargeFactor: 0.1,
                viewportFraction: 1,
                aspectRatio: 16 / 9,
              )),
        ),
      ],
    );
  }
}
