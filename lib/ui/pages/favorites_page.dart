import 'package:flutter/material.dart';
import 'package:wisgen/ui/widgets/favorite_list.dart';

///Casing around the [FavoriteList].
///
///Handles [AppBar] & Swipe Navigation
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) =>
              _swipeNavigation(context, details),
          child: FavoriteList(),
        ));
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Favorite Wisdoms',
        style: Theme.of(context).textTheme.headline,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  ///Navigation
  void _swipeNavigation(BuildContext context, DragEndDetails details) {
    if (details.primaryVelocity.compareTo(0) == 1) //left to right
      Navigator.of(context).pop();
  }
}
