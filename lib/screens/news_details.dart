import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../config/colors.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, dynamic> article;

  DetailsPage({required this.article});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0.3,
        toolbarHeight: 70.0,
        title: Text(
          article['name'],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 160.0,
            width: screenWidth,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0.0),
                topRight: Radius.circular(0.0),
              ),
              child: Image.network(
                article['image'] ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Publié ${timeago.format(
                      DateTime.parse(article['date']),
                      locale: 'fr',
                    )}",
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    article['titre'],
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    article['description'],
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    article['content'],
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextButton(
                    onPressed: () async {
                      String url = article['url'];
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        // Gérer l'erreur si le lien ne peut pas être ouvert
                      }
                    },
                    child: const Text(
                      "Lire plus...",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
