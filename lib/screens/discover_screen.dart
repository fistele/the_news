import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/colors.dart';
import 'widgets/free.dart';
import 'widgets/most_recents.dart';
import 'widgets/tendance.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: AppColors.backgroundColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.backgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0.2,
          title: const Text(
            'Découvrir',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          bottom: const TabBar(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            tabs: [
              Tab(text: 'Gratuits'),
              Tab(text: 'Tendance'),
              Tab(text: 'Plus récents'),
            ],
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.primaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3.0,
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: const Free(),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: const Tendance(),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: const Recents(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
