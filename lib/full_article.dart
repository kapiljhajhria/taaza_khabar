import 'package:flutter/material.dart';

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
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Hero(
              tag: widget.article.title,
              child: Image.network(
                widget.article.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    widget.article.title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                    widget.article.content,
                    style: Theme.of(context).textTheme.body1,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
