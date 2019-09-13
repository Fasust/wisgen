import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:wisgen/blocs/favorite_bloc.dart';
import 'package:wisgen/blocs/favorite_event.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/ui/ui_helper.dart';
import 'package:wisgen/ui/widgets/card_wisdom.dart';

class PageFavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            _swipeNavigation(context, details);
          },
          child: _listView(context),
        ));
  }

  //UI-Elements ---
  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Favorite Wisdoms',
        style: Theme.of(context).textTheme.headline,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  Widget _listView(BuildContext context) {
    //Subscribing the ListView to the Favorite BLoC
    return BlocBuilder<FavoriteBloc, List<Wisdom>>(
        builder: (context, favorites) {
      if (favorites.length == 0) {
        return Container(
          alignment: Alignment(0.0, 0.0),
          child: Text("You don't have and Favorites jet"),
        );
      }
      return ListView.builder(
        padding: EdgeInsets.all(UIHelper.listPadding),
        itemBuilder: (context, i) {
          if (favorites.length > i) {
            Wisdom wisdom = favorites[i];
            return CardWisdom(
              wisdom: wisdom,
            );
          }
        },
      );
    });
  }
}

//Navigation ---
void _swipeNavigation(BuildContext context, DragEndDetails details) {
  if (details.primaryVelocity.compareTo(0) == 1) //left to right
    Navigator.of(context).pop();
}
