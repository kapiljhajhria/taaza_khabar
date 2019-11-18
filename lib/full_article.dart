import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'article_class.dart';
class DetailedArticle extends StatefulWidget {
  final Article article;

  DetailedArticle({this.article});
  @override
  _DetailedArticleState createState() => _DetailedArticleState();
}

class _DetailedArticleState extends State<DetailedArticle> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Hero(
                tag: widget.article.title,
                child: Image.network(
                  widget.article.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        // title
                        Text(
                          widget.article.title,
                          style: Theme.of(context).textTheme.title,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Icon(Icons.new_releases),
                            SizedBox(width: 5),
                            Text(widget.article.author),
                            SizedBox(width: 10),
                            Icon(Icons.calendar_today),
                            SizedBox(width: 5),
                            Text('19-Nov-2019'),
                            SizedBox(width: 10),
                            Icon(Icons.access_time),
                            SizedBox(width: 5),
                            Text(widget.article.hoursAgo),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.article.content,
                          style: Theme.of(context).textTheme.body1,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    launch(widget.article.fullNewsUrl);
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Read Full Article',
                        style: Theme.of(context).textTheme.body1,
                      ),
                      SizedBox(width: 5,),
                      Icon(Icons.open_in_new)

                    ],
                  ),
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
}
