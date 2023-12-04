import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config/api_keys.dart';
import '../config/colors.dart';

class Article {
  final String author;
  final String title;
  final String description;
  final String urlToImage;

  Article({
    required this.author,
    required this.title,
    required this.description,
    required this.urlToImage,
  });
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isFocused = false;
  List<Article> articles = [];
  List<Article> topArticles = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    Apis apis = Apis();
    final apiKey = apis.tracy;
    final url = 'https://newsapi.org/v2/everything?q=all&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        topArticles = List.from(data['articles'])
            .map<Article>((source) => Article(
                  author: source['author'].toString(),
                  title: source['title'].toString(),
                  description: source['description'].toString(),
                  urlToImage: source['urlToImage'].toString(),
                ))
            .toList();

        setState(() {
          articles = List<Article>.from(topArticles);
        });
      } else {
        print('Erreur de chargement des articles');
      }
    } catch (e) {
      print('Erreur: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        backgroundColor: AppColors.backgroundColor,
        elevation: 0.3,
        title: Column(
          children: [
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.search,
                        color: AppColors.black800,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Recherche',
                          suffixIcon: isFocused
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isFocused = false;
                                      searchController.clear();
                                      articles =
                                          List<Article>.from(topArticles);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: AppColors.black800,
                                  ),
                                )
                              : null,
                        ),
                        onChanged: (value) {
                          setState(() {
                            articles = topArticles
                                .where((article) =>
                                    article.title
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    article.author
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    article.description
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15.0),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5.0),
              SizedBox(
                height: screenHeight - appBarHeight,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: (articles.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    final firstIndex = index * 2;
                    final secondIndex = firstIndex + 1;

                    return Column(
                      children: [
                        const SizedBox(height: 20.0),
                        Row(
                          children: [
                            if (firstIndex < articles.length)
                              Expanded(
                                child: Container(
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
                                  child: buildArticleCard(articles[firstIndex]),
                                ),
                              ),
                            if (secondIndex < articles.length)
                              Expanded(
                                child: Container(
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
                                  child:
                                      buildArticleCard(articles[secondIndex]),
                                ),
                              ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildArticleCard(Article article) {
    return Column(
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
              Text(
                article.author,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
