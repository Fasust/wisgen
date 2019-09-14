import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisgen/blocs/favorite_bloc.dart';
import 'package:wisgen/ui/page_favorites.dart';
import 'package:wisgen/ui/page_wisdom_feed.dart';

///As it is the Rout of the WWidget Tree, Services That need to be
///Globally Provided are Set up here
void main() => runApp(BlocProvider(
      //Globally Providing the Favorite BLoC as it is needed on multiple pages
      builder: (BuildContext context) => FavoriteBloc(),
      child: MyApp(),
    ));

///Sets Global Theme & Sets Navigation Routes. 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: <String, WidgetBuilder>{
          "/favorites": (context) => FavoriteList()
        },
        theme: ThemeData(
            primaryColor: Color.fromRGBO(56, 43, 115, 1),
            accentColor: Colors.grey,
            textTheme: TextTheme(
                headline: TextStyle(color: Colors.white, fontSize: 23))),
        home: WisdomFeed());
  }
}
