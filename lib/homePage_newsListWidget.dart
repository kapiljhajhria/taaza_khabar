import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:share/share.dart';
import 'package:taaza_khabar/article_class.dart';
import 'article_class.dart';
import 'full_article.dart';

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
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

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
                return ListTile(
                  dense: true,
                  onTap: () {
                    print('tapped');
                    Navigator.push(
                        (context),
                        MaterialPageRoute(
                            builder: (context) => DetailedArticle(
                                  article: allArticlesList[index],
                                )));
                  },
                  contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  title: Container(
//              height: 200,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        //title
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            allArticlesList[index].title,
                            style: Theme.of(context).textTheme.headline,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.justify,
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
                                      style:
                                      Theme.of(context).textTheme.subhead,
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
                                    child: allArticlesList[index].imageUrl.isNotEmpty
                                        ? Image.network(
                                      allArticlesList[index].imageUrl,
                                            fit: BoxFit.fill,
                                          )
                                        : Image.asset(
                                            'assets/defaultimage.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
//                  source , time,  bookmark and share icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                        allArticlesList[index].author,
                                        style: TextStyle(color: Colors.grey)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                          allArticlesList[index].hoursAgo,
                                          style: TextStyle(color: Colors.grey)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.all(2.0),
                                child: IconButton(
                                  icon: Icon(Icons.share),
                                  color: Colors.blueGrey,
                                  onPressed: () {
                                    Share.share(
                                        '${allArticlesList[index].title}\n ${allArticlesList[index].fullNewsUrl} ');
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          color: Colors.black12,
                          height: 2.0,
                        ),
                      ],
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
}
