import 'dart:convert';
import 'package:http/http.dart';
import 'package:taaza_khabar/article_class.dart';
import 'article_class.dart';

class NewsJsonUrl {
  String myNewsApiKey = "";

  String topHeadlinesOfCountry({String countryCode}) {
    return 'https://newsapi.org/v2/top-headlines?country=$countryCode&apiKey=$myNewsApiKey';
  }

  String searchForNews({String searchTerm}) {
    searchTerm = searchTerm.replaceAll(' ', '%').toLowerCase();
    return 'https://newsapi.org/v2/everything?q=$searchTerm&apiKey=$myNewsApiKey';
  }

  String test(String test) {
    return test;
  }

  String countryNameFromId(String countryId) {
    return 'India';
  }

  String newsOfCountryByCategory({String category, String countryId}) {
    return 'https://newsapi.org/v2/top-headlines?country=$countryId&category=$category&apiKey=$myNewsApiKey';
  }

  Future<Map<String, dynamic>> getMapFromJson(String url) async {
    print('url here is $url'); //  debug
    Response response = await get(url);
    Map<String, dynamic> newsDataMap = jsonDecode(response.body);
    return newsDataMap;
  }
}

void main() async {
  Map<String, dynamic> everything = await NewsJsonUrl()
      .getMapFromJson(NewsJsonUrl().topHeadlinesOfCountry(countryCode: 'in'));
  FullMap justTestMap = FullMap(everything);
  print(justTestMap.status);
  print(justTestMap.results);
  ArticlesList allNewsArticles = ArticlesList(justTestMap.articlesListOfMap);
  print(allNewsArticles.allArticles[0].publishedAt);
}
