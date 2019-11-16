import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:taaza_khabar/article_class.dart';
import 'article_class.dart';

class ListBuilderBasedOnUrl extends StatefulWidget {
  final String url;

  ListBuilderBasedOnUrl({this.url});
  @override
  _ListBuilderBasedOnUrlState createState() => _ListBuilderBasedOnUrlState();
}

class _ListBuilderBasedOnUrlState extends State<ListBuilderBasedOnUrl>
    with AutomaticKeepAliveClientMixin<ListBuilderBasedOnUrl> {
  bool fetchedNews = true;
  List<Article> allArticlesList;

  @override
  void initState() {
    fetchedNews = false;
    getArticlesList();
    // TODO: implement initState
    super.initState();
  }

  getArticlesList() async {
    Response response = await get(widget.url);
    //get raw json data,  from URL
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    //convert jsonData to Map, this is still not the actual map tha we will be
    //using to create list of Article Object, we need just one value from
    //this map which is List of Maps and it will be converted into
    //List of Article Objects
    FullMap fullMapFromJsonData = FullMap(jsonData);
    //now that we have full map, we ned to get list of maps that will be
    //converted into list of objects of class Article
    List<dynamic> articlesMapList = fullMapFromJsonData.articlesListOfMap;
    //above we have list of maps, lets convert it into List of objects of class Article
    allArticlesList = ArticlesList(articlesMapList).allArticles;

    print('test');
    print(allArticlesList[0].title);
    fetchedNews = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        fetchedNews = false;
        getArticlesList();
      },
      child: fetchedNews
          ? ListView.builder(
              shrinkWrap: true,
              primary: true,
              padding: EdgeInsets.only(top: 10),
              itemCount: allArticlesList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    onLongPress: () {
                      print('long press');
                    },
                    dense: true,
                    onTap: () {
                      Locale myLocale = Localizations.localeOf(context);
                      print(myLocale.countryCode);
                      print(myLocale.languageCode);
                      print(DateTime.now());
                      print('tapped');
                    },
                    contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    title: Container(
//              height: 200,
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          //title
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              allArticlesList[index].title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              strutStyle: StrutStyle(height: 1),
                            ),
                          ),
//                  description and image
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                      margin: EdgeInsets.all(2.0),
                                      child: Text(
                                        allArticlesList[index].description,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 5,
                                        strutStyle: StrutStyle(height: 1),
                                      )),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin: EdgeInsets.all(2.0),
                                    child: Hero(
                                      createRectTween: (Rect r1, Rect r2) =>
                                          RectTween(begin: r1, end: r2),
                                      tag: allArticlesList[index].title,
                                      child: allArticlesList[index]
                                              .imageUrl
                                              .isNotEmpty
                                          ? Image.network(
                                              allArticlesList[index].imageUrl,
                                              fit: BoxFit.fill,
                                            )
                                          : Text('No Image'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
//                  source , time,  bookmark and share icon
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            color: Colors.black12,
                            height: 2.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
          : Center(
              child: CircularProgressIndicator(
              strokeWidth: 3.0,
              backgroundColor: Colors.red,
            )),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
