import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../search_screen.dart';

Widget buildArticleCard(Article article) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 160.0,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Image.network(
            article.urlToImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(height: 8.0),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const Icon(
                  Icons.person_2_outlined,
                  size: 16.0,
                  color: AppColors.primaryColor,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  article.author,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ],
  );
}
