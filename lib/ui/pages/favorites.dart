import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisgen/blocs/favorite_bloc.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/ui/ui_helper.dart';
import 'package:wisgen/ui/widgets/wisdom_card.dart';

///Subscribes to Global FavoriteBLoC and Displays the Published
///Favorites as a ListView
class FavoriteList extends StatelessWidget {
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
      if (favorites.length == 0) return _emptyList(context);
      return ListView.builder(
        padding: EdgeInsets.all(UIHelper.listPadding),
        itemBuilder: (context, i) {
          if (favorites.length > i) {
            Wisdom wisdom = favorites[i];
            return WisdomCard(
              wisdom: wisdom,
            );
          }
        },
      );
    });
  }
  
  Widget _emptyList(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        "Nothing Here 🤷‍♂️",
        style: Theme.of(context).textTheme.subtitle,
      )),
      //filling blank space with White background to register as dargable widget
      constraints: BoxConstraints.expand(),
      color: Colors.white, 
    );
  }

  ///Navigation
  void _swipeNavigation(BuildContext context, DragEndDetails details) {
    if (details.primaryVelocity.compareTo(0) == 1) //left to right
      Navigator.of(context).pop();
  }
}
