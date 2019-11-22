import 'dart:convert';
import 'package:http/http.dart';
import 'package:taaza_khabar/article_class.dart';
import 'article_class.dart';

class NewsJsonUrl {
  String myNewsApiKey = "cbd79dfc4ee4413496a4aca82d4b02ec";

  String topHeadlinesOfCountry({String countryCode}) {
    print('https://newsapi.org/v2/top-headlines?country=$countryCode&apiKey=$myNewsApiKey');
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
  Map<String, dynamic> jsonData = await NewsJsonUrl()
      .getMapFromJson(NewsJsonUrl().searchForNews(searchTerm: 'donald trump'));
  FullMap fullMapFromJsonData = FullMap(jsonData);
  // print(fullMapFromJsonData.status);
  // print(fullMapFromJsonData.results);
  ArticlesList newsMap = ArticlesList(fullMapFromJsonData.articlesListOfMap);
  // print(newsMap.allArticles[2].title);
  // print(newsMap.allArticles[2].author);
  // print(newsMap.allArticles.length);
  // print(newsMap.allArticles[2].humanReadableTime);
}
