import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page._screen.dart';
import 'full_article.dart';

void main() => runApp(NewsApp());

class NewsApp extends StatefulWidget {
  @override
  _NewsAppState createState() => _NewsAppState();
}

bool usingDarkTheme = true;



class _NewsAppState extends State<NewsApp> {
  ///light theme
     handleSettingsChange() {
       setState(() {
         
       });
  }


  @override
  Widget build(BuildContext context) {
    ///light theme
    ThemeData lightTheme = ThemeData(
      //primary color is being used as app bar color, so set it accordingly
      primaryColor: Colors.white,
//    brightness: Brightness.light,
//    primaryColorBrightness: Brightness.dark,
      tabBarTheme: TabBarTheme(
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelStyle: TextStyle(fontSize: 19),
          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          labelPadding: EdgeInsets.fromLTRB(10, 0, 10, 10)),

      textTheme: TextTheme(

        ///headline = main list headline
        headline: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'linlibertine_r',

        ),

        ///subHead = main list description below headline
        subhead: TextStyle(
            fontFamily: 'linlibertine_dr'),


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
//    primaryColor: Colors.grey,
//    accentColor: Colors.green,
//    primaryColorLight: Colors.green,
//    appBarTheme: AppBarTheme(
//      color: Colors.green
//
//    )


    );
    ///dark theme
    ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColorBrightness: Brightness.dark,
      tabBarTheme: TabBarTheme(
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelStyle: TextStyle(fontSize: 19),
          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          labelPadding: EdgeInsets.fromLTRB(10, 0, 10, 10)),

      textTheme: TextTheme(
        ///headline = main list headline
        headline: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'linlibertine_r'
        ),

        ///subHead = main list description below headline
        subhead: TextStyle(
            fontFamily: 'linlibertine_dr'),


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

    );
    List<ThemeData> appThemes =[lightTheme,darkTheme];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: usingDarkTheme?appThemes[1]:appThemes[0],
      routes: {
        '/': (context) => HomePage(settingsCallback: handleSettingsChange,),
                'detailed_article': (context) => DetailedArticle(),
        //        'image': (context) => RegisterScreen(),
              },
            );
          }
        
    
}
