import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisgen/favList.dart';
import 'cardFeed.dart';
import 'data/wisdomFavlist.dart';

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
