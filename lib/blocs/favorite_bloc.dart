import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wisgen/models/wisdom.dart';

import 'favorite_event.dart';

///The FavoriteBLoC is Responsible for Keeping track of the
///Favorite List. It receives Events to Add and remove Favorite
///Wisdoms and Broadcasts the Complete List of Favorites.
class FavoriteBloc extends Bloc<FavoriteEvent, List<Wisdom>> {
  @override
  List<Wisdom> get initialState => List<Wisdom>();

  @override
  Stream<List<Wisdom>> mapEventToState(FavoriteEvent event) async* {
    List<Wisdom> newFavorites = List()..addAll(currentState);

    if (event is FavoriteEventAdd) newFavorites.add(event.favorite);
    if (event is FavoriteEventRemove) newFavorites.remove(event.favorite);

    yield newFavorites;
  }
}
