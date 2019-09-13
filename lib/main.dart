import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisgen/blocs/favorite_bloc.dart';
import 'package:wisgen/ui/page_favorites.dart';
import 'package:wisgen/ui/page_wisdom_feed.dart';

void main() => runApp(BlocProvider(
      //Globally Providing the Favorite BLoC as it is needed on multiple pages
      builder: (BuildContext context) => FavoriteBloc(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: <String, WidgetBuilder>{
          "/favorites": (context) => PageFavoriteList()
        },
        theme: ThemeData(
            primaryColor: Color.fromRGBO(56, 43, 115, 1),
            accentColor: Colors.grey,
            textTheme: TextTheme(
                headline: TextStyle(color: Colors.white, fontSize: 23))),
        home: PageWisdomFeed());
  }
}
