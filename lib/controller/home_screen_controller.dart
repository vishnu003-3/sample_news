import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/home_screen_model.dart';

class HomeScreenController with ChangeNotifier {
  List<Article>? articlesList = [];
  List<Article>? filteredArticles = [];
  bool isLoading = false;

  getNews(String category) async {
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$category&apiKey=37cd22cee6d14bf78b9a3cfed10783c7");
    try {
      isLoading = true;
      notifyListeners();
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = homemodelFromJson(response.body);
        articlesList = jsonData.articles ?? [];
        filteredArticles = articlesList; // Initially, show all articles.
      }
    } catch (e) {
      log(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  void searchArticles(String searchname) {
    if (searchname.isEmpty) {
      filteredArticles = articlesList;
    } else {
      filteredArticles = articlesList
          ?.where((article) =>
              (article.title?.toLowerCase() ?? '')
                  .contains(searchname.toLowerCase()) ||
              (article.description?.toLowerCase() ?? '')
                  .contains(searchname.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
