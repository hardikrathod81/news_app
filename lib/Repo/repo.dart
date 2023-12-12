import 'dart:convert';

import 'package:news_app/Model/catregory_model.dart';
import 'package:news_app/Model/news_model.dart';
import 'package:http/http.dart' as http;

class NewsRepo {
  Future<NewsHeadLinesModel> fetchNewsHeadLinesModel(String name) async {
    String newsuri =
        'https://newsapi.org/v2/top-headlines?country=$name&category=business&apiKey=5ea248995a0e440e9d3dc55a84091e8a';

    final responce = await http.get(Uri.parse(newsuri));
    if (responce.statusCode == 200) {
      final body = jsonDecode(responce.body);
      return NewsHeadLinesModel.fromJson(body);
    } else {
      throw Error();
    }
  }
}

class CategoryNewsRepo {
  Future<CategoryModel> fetchCategoryNewsModelApi(String category) async {
    String newsuri =
        'https://newsapi.org/v2/everything?q=$category&apiKey=5ea248995a0e440e9d3dc55a84091e8a';

    final responce = await http.get(Uri.parse(newsuri));
    if (responce.statusCode == 200) {
      final body = jsonDecode(responce.body);
      return CategoryModel.fromJson(body);
    } else {
      throw Error();
    }
  }
}
