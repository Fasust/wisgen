import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisgen/blocs/favorite_bloc.dart';
import 'package:wisgen/ui/pages/favorites.dart';
import 'package:wisgen/ui/pages/wisdom_feed.dart';

void main() => runApp(MyApp());

///Sets Global Theme & Sets Navigation Routes.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Globally Providing the Favorite BLoC as it is needed on multiple pages
    return BlocProvider(
      builder: (BuildContext context) => FavoriteBloc(),
      child: MaterialApp(
          routes: <String, WidgetBuilder>{
            "/favorites": (context) => FavoriteList()
          },
          theme: ThemeData(
              primaryColor: Color.fromRGBO(56, 43, 115, 1),
              accentColor: Colors.grey,
              textTheme: TextTheme(
                  headline: TextStyle(color: Colors.white, fontSize: 23))),
          home: WisdomFeed()),
    );
  }
}
