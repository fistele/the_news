import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../config/api_keys.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = [];
  final categoryIcons = [
    Icons.public,
    Icons.business_center,
    Icons.computer,
    Icons.sports,
    Icons.movie,
    Icons.local_hospital,
    Icons.science,
  ];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    Apis apis = Apis();
    final apiKey = apis.tracy;
    final url = 'https://newsapi.org/v2/top-headlines/sources?apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        final sources = List.from(data['sources']);
        final uniqueCategories = sources
            .map<String>((source) => source['category'].toString())
            .toSet()
            .toList();
        setState(() {
          categories = List<String>.from(uniqueCategories);
        });
      } else {
        print('Erreur de chargement des catégories');
      }
    } catch (e) {
      print('Erreur: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Container(
          width: 105.0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  shape: BoxShape.circle,
                ),
              ),
              Icon(
                categoryIcons[index],
                color: Colors.black,
              ),
              Positioned(
                bottom: 0,
                child: Text(
                  categories[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
