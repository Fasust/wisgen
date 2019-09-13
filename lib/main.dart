import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisgen/ui/page_favorites.dart';
import 'package:wisgen/ui/page_wisdom_feed.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: <String, WidgetBuilder>{"/favorites": (context) => PageFavoriteList()},
        theme: ThemeData(
            primaryColor: Color.fromRGBO(56, 43, 115, 1),
            accentColor: Color.fromRGBO(255, 243, 53, 1),
            textTheme: TextTheme(
                headline: TextStyle(color: Colors.white, fontSize: 23))),
        home: PageWisdomFeed());
  }
}
