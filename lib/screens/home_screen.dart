import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/screens/widgets/categories.dart';

import '../config/colors.dart';
import 'widgets/most_popular.dart';
import 'widgets/recommendations.dart';
import 'widgets/slide.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homepage';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          backgroundColor: AppColors.backgroundColor,
          elevation: 0.2,
          title: Center(
            child: Text(
              'THE NEWS',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'LilitaOne',
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [
                      AppColors.primaryColor,
                      AppColors.purpleColor,
                    ],
                  ).createShader(
                    const Rect.fromLTWH(
                      0.0,
                      0.0,
                      450.0,
                      50.0,
                    ),
                  ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Carousel(),
              const SizedBox(
                height: 100,
                child: Categories(),
              ),
              const SizedBox(height: 15.0),
              const Recommendations(),
              const SizedBox(height: 15.0),
              const MostPopular(),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
