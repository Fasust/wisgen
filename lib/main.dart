import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisgen/page_favorites.dart';
import 'package:wisgen/page_wisdom_feed.dart';
import 'package:wisgen/provider/wisdom_fav_list.dart';

void main() => runApp(ChangeNotifierProvider(
    builder: (context) => WisdomFavList(), child: MyApp()));

/**
 * Material App Frame
 * Loads CardFeed
 */
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: <String, WidgetBuilder>{"/favorites": (context) => FavList()},
        theme: ThemeData(
            primaryColor: Color.fromRGBO(56, 43, 115, 1),
            textTheme: TextTheme(
                headline: TextStyle(color: Colors.white, fontSize: 23))),
        home: CardFeed());
  }
}
