import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../config/api_keys.dart';
import '../../config/colors.dart';
import '../news_details.dart';

class Recents extends StatefulWidget {
  const Recents({super.key, Key});

  @override
  _RecentsState createState() => _RecentsState();
}

class _RecentsState extends State<Recents> {
  List<Map<String, dynamic>> recents = [];

  @override
  void initState() {
    super.initState();
    fetchRecents();
  }

  Future<void> fetchRecents() async {
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(const Duration(days: 1));
    String formattedYesterday = DateFormat('yyyy-MM-dd').format(yesterday);
    Apis apis = Apis();
    final apiKey = apis.tracy;
    final url =
        'https://newsapi.org/v2/everything?q=all&from=$formattedYesterday&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        final sources = List.from(data['articles']);
        final topRecents = sources
            .take(5)
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
          recents = List<Map<String, dynamic>>.from(topRecents);
        });
      } else {
        print('Erreur de chargement des tendances');
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
              itemCount: recents.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          article: recents[index],
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.watch_later_outlined,
                                              size: 25.0,
                                              color: Colors.orange,
                                            ),
                                            const SizedBox(width: 5.0),
                                            Text(
                                              timeago.format(
                                                DateTime.parse(
                                                    recents[index]['date']),
                                                locale: 'fr',
                                              ),
                                              style: const TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.orange,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 35.0,
                                right: 10.0,
                              ),
                              child: Text(
                                extractNameInParentheses(
                                  recents[index]['titre'],
                                ),
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: AppColors.black800,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
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
