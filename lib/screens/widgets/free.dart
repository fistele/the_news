import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;
import '../../config/api_keys.dart';
import '../../config/colors.dart';
import '../news_details.dart';

class Free extends StatefulWidget {
  const Free({super.key, Key});

  @override
  _FreeState createState() => _FreeState();
}

class _FreeState extends State<Free> {
  List<Map<String, dynamic>> free = [];

  @override
  void initState() {
    super.initState();
    fetchFree();
  }

  Future<void> fetchFree() async {
    Apis apis = Apis();
    final apiKey = apis.tracy;
    final url = 'https://newsapi.org/v2/everything?q=gratuit&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        final sources = List.from(data['articles']);
        final topFree = sources
            .map<Map<String, dynamic>>((source) => {
                  'name': source['source']['name'].toString(),
                  'description': source['description'].toString(),
                  'url': source['url'].toString(),
                  'content': source['content'].toString(),
                  'titre': source['title'].toString(),
                  'auteur': source['author'].toString(),
                  'image': source['urlToImage'] ?? '',
                  'date': source['publishedAt'] ?? '01-12-2023',
                })
            .toList();
        setState(() {
          free = List<Map<String, dynamic>>.from(topFree);
        });
      } else {
        print('Erreur de chargement des plus populaires');
      }
    } catch (e) {
      print('Erreur: $e');
    }
  }

  String extractNameInParentheses(String input) {
    RegExp regex = RegExp(r'\(([^)]*)\)');
    RegExp regexUrl = RegExp(r'https:\/\/www\.facebook\.com\/([^\/]+)');
    if (regex.firstMatch(input) != null) {
      Match match = regex.firstMatch(input)!;
      if (match.groupCount > 0) {
        return match.group(1) ?? input;
      } else {
        return input;
      }
    } else {
      Match? matchUrl = regexUrl.firstMatch(input);
      if (matchUrl != null && matchUrl.groupCount >= 1) {
        return matchUrl.group(1) ?? input;
      } else {
        return input;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = AppBar().preferredSize.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: screenHeight - appBarHeight,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: free.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          article: free[index],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 160.0,
                              width: screenWidth,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                                child: Image.network(
                                  free[index]['image'] ?? '',
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
                                    extractNameInParentheses(
                                      free[index]['titre'],
                                    ),
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    free[index]['description'],
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.watch_later_outlined,
                                              size: 16.0,
                                              color: Colors.black,
                                            ),
                                            const SizedBox(width: 5.0),
                                            Text(
                                              timeago.format(
                                                DateTime.parse(
                                                    free[index]['date']),
                                                locale: 'fr',
                                              ),
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            const Icon(
                                              Icons.person_2_outlined,
                                              size: 16.0,
                                              color: AppColors.primaryColor,
                                            ),
                                            const SizedBox(width: 5.0),
                                            Text(
                                              free[index]['auteur'],
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 30.0)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
