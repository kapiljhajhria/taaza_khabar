import 'package:flutter/material.dart';
import 'homePage_newsListWidget.dart';
import 'netwrok_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

NewsJsonUrl newsJsonUrl = NewsJsonUrl();

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListBuilderBasedOnUrl(
      url: newsJsonUrl.topHeadlinesOfCountry(countryCode: 'in'),
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
