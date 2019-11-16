import 'package:flutter/material.dart';
import 'home_page._screen.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: TextTheme(
          ///headline = main list headline
          headline: TextStyle(
            fontSize: 21.0,
          ),

          ///subHead = main list description below headline
          subhead: TextStyle(
            fontSize: 15.0,
          ),

          ///title =  detailed page  headline
          title: TextStyle(
            fontSize: 18.0,
            fontStyle: FontStyle.italic,
          ),

          ///subtitle = detailed widget/page image description
          subtitle: TextStyle(fontSize: 12, color: Colors.white30),

          ///body1 = detailed widget/page content
          body1: TextStyle(fontSize: 14.0),
        ),
      ),
      routes: {
        '/': (context) => HomePage(),
        'detailed_article': (context) => DetailedArticle(),
//        'image': (context) => RegisterScreen(),
      },
    );
  }
}
