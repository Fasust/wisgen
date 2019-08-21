import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisgen/provider/wisdom_fav_list.dart';

import 'card_advice.dart';

class PageFavoriteList extends StatelessWidget {
  static const double _margin = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {_swpipeNavigation(context, details);},
        child: Consumer<WisdomFavList>(
          builder: (context, favorites, _) => _buildListView(favorites),
        ),
      ),
    );
  }

  //UI-Elements -----
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Favorite Wisdoms',
        style: Theme.of(context).textTheme.headline,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  ListView _buildListView(WisdomFavList favorites) {
    return ListView.builder(
      padding: EdgeInsets.all(_margin),
      itemBuilder: (context, i) {
        if (favorites.length() > i) {
          return new CardAdvice(
            wisdom: favorites.getAt(i),
            onLike: () {
              favorites.removeAt(i);
            },
          );
        } else {
          return null;
        }
      },
    );
  }
}

//Helper Functions
void _swpipeNavigation(BuildContext context, DragEndDetails details) {
  if (details.primaryVelocity.compareTo(0) == 1) //left to right
    Navigator.of(context).pop();
}
