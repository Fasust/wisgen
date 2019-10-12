import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisgen/blocs/favorite_bloc.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/ui/widgets/wisdom_card.dart';

import '../ui_helper.dart';
import 'empty_list.dart';

///Display a list of all favorite [Wisdom]s.
///
///Subscribes to global [FavoriteBLoC] and displays the published
///Favorites as a ListView
class FavoriteList extends StatelessWidget {
  const FavoriteList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Subscribing the ListView to the Favorite BLoC
    return BlocBuilder<FavoriteBloc, List<Wisdom>>(
        builder: (context, favorites) {
      if (favorites.length == 0) return EmptyList();
      return ListView.builder(
        padding: EdgeInsets.all(UiHelper.listPadding),
        itemBuilder: (context, i) {
          if (favorites.length > i) {
            Wisdom wisdom = favorites[i];
            return WisdomCard(wisdom);
          }
        },
      );
    });
  }
}
