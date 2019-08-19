import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisgen/provider/wisdom_fav_list.dart';

import 'card_advice.dart';


class FavList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Wisdoms',
          style: Theme.of(context).textTheme.headline,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Consumer<WisdomFavList>(
        builder: (context, favorites, _) => 
        ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, i) {
            if(favorites.length() > i){
              return new AdviceCard(wisdom: favorites.getAt(i),onLike: (){
                favorites.removeAt(i);
              },);
            }else{
              return null;
            }
          },
        ),
      ),
    );
  }
}
