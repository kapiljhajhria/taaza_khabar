import 'dart:convert';
import 'package:http/http.dart';
import 'package:taaza_khabar/article_class.dart';
import 'article_class.dart';

class NewsJsonUrl {
  String myNewsApiKey = "";

//  NewsJsonUrl({ String countryTopNews}) {
//    this.country = countryTopNews;
//    this.url =
//        'https://newsapi.org/v2/top-headlines?country=$countryTopNews&apiKey=$myNewsApiKey';
//  }

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

//  The category you want to get headlines for.
//  Possible options: business entertainment general health science sports technology
//  https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=$myNewsApiKey
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
  String topNews = NewsJsonUrl().topHeadlinesOfCountry(countryCode: 'in');
  print(topNews);
  Map<String, dynamic> everything = await NewsJsonUrl().getMapFromJson(topNews);
  FullMap justTestMap = FullMap(everything);
  print(justTestMap.status);
  print(justTestMap.results);
//  print(justTestMap.articlesList[0]);
  List<dynamic> allArticlesList = justTestMap.articlesList;
  print(allArticlesList[0]);
//  var SearchLink = NewsJsonUrl().searchForNews(searchTerm: 'your trump');
//  print(SearchLink);
}

//top headlines search
//https://newsapi.org/v2/top-headlines?q=trump&apiKey=$myNews

//everything search sort by and to from
//https://newsapi.org/v2/everything?q=apple&from=2019-11-11&to=2019-11-11&sortBy=popularity&apiKey=$myNewsApiKey
//
//sortBy
//
//The order to sort the articles in. Possible options: relevancy, popularity, publishedAt.
//relevancy = articles more closely related to q come first.
//popularity = articles from popular sources and publishers come first.
//publishedAt = newest articles come first.
//Default: publishedAt
