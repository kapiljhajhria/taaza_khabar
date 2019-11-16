import 'dart:convert';

import 'package:flutter/material.dart';
import 'article_class.dart';
import 'homePage_newsList.dart';
import 'netwrok_helper.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

NewsJsonUrl newsJsonUrl = NewsJsonUrl();

class _HomePageState extends State<HomePage> {
  bool fetchedNews = false;
  List<Article> allArticlesList = [];
  List<Article> allArticlesList2 = [];

  @override
  void initState() {
    fetchedNews = false;
    getArticlesList(
        newsJsonUrl.topHeadlinesOfCountry(countryCode: 'in'), allArticlesList2);

    // TODO: implement initState
    super.initState();
  }

//url that we need to get json Data from
  getArticlesList(String url, List<Article> allArticlesList) async {
    Response response = await get(url);
    //get raw json data,  from URL
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    //convert jsonData to Map, this is still not the actual map tha we will be
    //using to crea list of Article Object, we need just one value from
    //this map which is List of Maps and it will be converted into
    //List of Article Objects
    FullMap fullMapFromJsonData = FullMap(jsonData);
    //now that we have full map, we ned to get list of maps that will be
    //coverted into list of objects of class Article
    List<dynamic> articlesMapList = fullMapFromJsonData.articlesListOfMap;
    //above we have list of maps, lets convert it into List of objects of class Article
    allArticlesList = ArticlesList(articlesMapList).allArticles;
    allArticlesList2 = ArticlesList(articlesMapList).allArticles;

    print('test');
    print(allArticlesList[0].title);
    fetchedNews = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          fetchedNews = false;
          getArticlesList(newsJsonUrl.topHeadlinesOfCountry(countryCode: 'in'),
              allArticlesList2);
        },
        child: fetchedNews
            ? RandomWidget(allArticlesList: allArticlesList2)
            : Center(
                child: CircularProgressIndicator(
                strokeWidth: 3.0,
                backgroundColor: Colors.red,
              )),
      ),
    );
  }
}

class LocationsSearch extends SearchDelegate<String> {
  List results = ['donald trump', 'football', 'Ram Mandir'];
  final List<dynamic> cities;

  LocationsSearch(this.cities);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: theme.primaryColor,
      primaryIconTheme: theme.primaryIconTheme,
      primaryColorBrightness: theme.primaryColorBrightness,
      primaryTextTheme: theme.primaryTextTheme,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
//    can display multiple icons on the top right corner
    //like close button,
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close)),
      IconButton(
        icon: Icon(Icons.clear_all),
        onPressed: () {
          results.clear();
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    // to close or back arrow on the top left
    //for now returning null
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    ///recently searched items suggested as we type

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.history),
          onTap: () {
            close(context, results[index]);
          },
          dense: true,
          title: Text(results[index]),
        );
      },
    );
  }
}
