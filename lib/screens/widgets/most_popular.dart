import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../config/api_keys.dart';

class MostPopular extends StatefulWidget {
  const MostPopular({super.key, Key});

  @override
  _MostPopularState createState() => _MostPopularState();
}

class _MostPopularState extends State<MostPopular> {
  List<Map<String, dynamic>> mostPopular = [];

  @override
  void initState() {
    super.initState();
    fetchMostPopular();
  }

  Future<void> fetchMostPopular() async {
    Apis apis = Apis();
    final apiKey = apis.tracy;
    final url = 'https://newsapi.org/v2/everything?q=Smartphone&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        final sources = List.from(data['articles']);
        final topPopular = sources
            .take(10)
            .map<Map<String, dynamic>>((source) => {
                  'name': source['author'].toString(),
                  'image': source['urlToImage'] ?? '',
                  'date': source['publishedAt'] ?? '01-12-2023',
                })
            .toList();
        setState(() {
          mostPopular = List<Map<String, dynamic>>.from(topPopular);
        });
      } else {
        print('Erreur de chargement des plus populaire');
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Plus populaire',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              TextButton(
                onPressed: () {
                  //je reviens si j'ai le temps
                },
                child: const Text(
                  'Voir tout',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5.0),
          SizedBox(
            height: 220.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mostPopular.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 150.0,
                  margin: const EdgeInsets.only(right: 15.0),
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
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          child: Image.network(
                            mostPopular[index]['image'] ?? '',
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
                                mostPopular[index]['name'],
                              ),
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              DateFormat('dd-MM-yyyy').format(
                                DateTime.parse(mostPopular[index]['date']),
                              ),
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
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
