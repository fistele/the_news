import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  Carousel({Key? key}) : super(key: key);

  final List<String> images = [
    'https://i.ytimg.com/vi/iWAFQirGMww/maxresdefault.jpg',
    'https://i.imgur.com/T2GbFHz.jpeg',
    'https://cheater.fun/uploads/posts/2021-06/1622834640_news-1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      options: CarouselOptions(
        aspectRatio: 14 / 8,
        viewportFraction: 1,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 500),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(0)),
          child: Image.network(images[index], fit: BoxFit.cover, width: 1000),
        );
      },
    );
  }
}
