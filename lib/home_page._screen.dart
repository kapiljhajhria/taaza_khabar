import 'package:flutter/material.dart';
import 'homePage_newsListWidget.dart';
import 'main.dart';
import 'netwrok_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  Settings appSettings;

  HomePage(this.appSettings);
  @override
  _HomePageState createState() => _HomePageState();
}

NewsJsonUrl newsJsonUrl = NewsJsonUrl();
int tabIndexOnLaunchOfApp;

class _HomePageState extends State<HomePage> {
  List<bool> toggleButtons = [true, false, false];

  @override
  void initState() {
    getValuesSF();
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  getValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tabIndexOnLaunchOfApp = prefs.getInt('tabIndexOnLaunchOfApp');
    tabIndexOnLaunchOfApp == null ? tabIndexOnLaunchOfApp = 0 : null;
    print('value from sp is');
    print(tabIndexOnLaunchOfApp);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
//    tabIndexOnLaunchOfApp == null ? tabIndexOnLaunchOfApp = 0 : null;
    return DefaultTabController(
      length: 5,
      initialIndex: tabIndexOnLaunchOfApp,
      child: Scaffold(
        drawer: Container(
          color: Theme.of(context).copyWith().accentColor,
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
//          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/defaultimage.png'),
              ListTile(
                title: Text('Dark Theme',style: TextStyle(fontSize: 16)),
                trailing:  Switch(

                    value: widget.appSettings.isDark,
                    onChanged: (toggleValue) {

                      // print('toggle value: $toggleValue usingDarkTheme : $usingDarkTheme');
//                      usingDarkTheme = !usingDarkTheme;
                      setState(() {
                        widget.appSettings.setIsDark(toggleValue);
              
                      });
                    },
                  ),
                ),
                 
              ListTile(title: Text('Settings',style: TextStyle(fontSize: 16),)),
              ListTile(title: Text('Credits',style: TextStyle(fontSize: 16),)),
            ],
          ),
        ),
          appBar: AppBar(
            
            backgroundColor: Theme.of(context).copyWith().primaryColor,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  dynamic newLocation = await showSearch(
                    context: context,
                    delegate: LocationsSearch(),
                  );
                  print('newLocation is $newLocation');
                  if (newLocation != null) {
                    setState(() {});
                  }
                },
              )
            ],
            title: Text('News App'),
            centerTitle: true,
            bottom: TabBar(
              onTap: (x) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setInt('tabIndexOnLaunchOfApp', x);
              },
              isScrollable: true,
              tabs: <Widget>[
                Text('India'),
                Text('Australia'),
                Text('USA'),
                Text('New Zeland'),
                Text('Indonesia'),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ListBuilderBasedOnUrl(
                url: newsJsonUrl.topHeadlinesOfCountry(countryCode: 'in'),
              ),
              ListBuilderBasedOnUrl(
                url: newsJsonUrl.topHeadlinesOfCountry(countryCode: 'au'),
              ),
              ListBuilderBasedOnUrl(
                url: newsJsonUrl.topHeadlinesOfCountry(countryCode: 'us'),
              ),
              ListBuilderBasedOnUrl(
                url: newsJsonUrl.topHeadlinesOfCountry(countryCode: 'nz'),
              ),
              ListBuilderBasedOnUrl(
                url: newsJsonUrl.topHeadlinesOfCountry(countryCode: 'id'),
              ),
            ],
          )),
    );
  }
}

class LocationsSearch extends SearchDelegate<String> {
  List results = ['donald trump', 'football', 'Ram Mandir'];
//  final List<dynamic> cities;
//
//  LocationsSearch(this.cities);

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
          print('clear results');
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
    results.add(query);
    // TODO: implement buildResults
    return ListBuilderBasedOnUrl(
      url: newsJsonUrl.searchForNews(searchTerm: query),
    );
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
            print('tapped ${results[index]}');
//            close(context, results[index]);
            query = results[index];
          },
          dense: true,
          title: Text(results[index]),
        );
      },
    );
  }
}
