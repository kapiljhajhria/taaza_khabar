import 'package:flutter/material.dart';
import 'package:taaza_khabar/article_class.dart';

class ScrollingNewsListAtHomePage extends StatefulWidget {
  final List<Article> allArticlesList;
  ScrollingNewsListAtHomePage({this.allArticlesList});
  @override
  _ScrollingNewsListAtHomePageState createState() =>
      _ScrollingNewsListAtHomePageState();
}

class _ScrollingNewsListAtHomePageState
    extends State<ScrollingNewsListAtHomePage> {
  @override
  Widget build(BuildContext context) {
    print('in home articles list widget');
    print(widget.allArticlesList[0].title);
    return ListView.builder(
        padding: EdgeInsets.only(top: 10),
        itemCount: widget.allArticlesList.length,
        itemBuilder: (context, index) {
          return ListTile(
            dense: true,
            onTap: () {
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
                      widget.allArticlesList[index].title,
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
                                widget.allArticlesList[index].description,
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
                              tag: widget.allArticlesList[index].title,
                              child: widget.allArticlesList[index].imageUrl
                                      .isNotEmpty
                                  ? Image.network(
                                      widget.allArticlesList[index].imageUrl,
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
          );
        });
  }
}

class RandomWidget extends StatelessWidget {
  final List<Article> allArticlesList;

  RandomWidget({this.allArticlesList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(top: 10),
        itemCount: allArticlesList.length,
        itemBuilder: (context, index) {
          return ListTile(
            dense: true,
            onTap: () {
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
                              child: allArticlesList[index].imageUrl.isNotEmpty
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
          );
        });
  }
}
