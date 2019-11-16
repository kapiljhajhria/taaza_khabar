import 'package:flutter/material.dart';
import 'home_page.dart';
import 'full_article.dart';

void main() => runApp(NewsApp());

class NewsApp extends StatefulWidget {
  @override
  _NewsAppState createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      routes: {
        '/': (context) => HomePage(),
        'detailed_article': (context) => DetailedArticle(),
//        'image': (context) => RegisterScreen(),
      },
    );
  }
}
