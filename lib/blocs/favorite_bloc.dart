import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/repositories/storage.dart';
import 'package:wisgen/repositories/storage_shared_preference.dart';

import 'favorite_event.dart';

///The FavoriteBLoC is Responsible for Keeping track of the
///Favorite List. It receives Events to Add and remove Favorite
///Wisdoms and Broadcasts the Complete List of Favorites.
class FavoriteBloc extends Bloc<FavoriteEvent, List<Wisdom>> {

  @override
  List<Wisdom> get initialState => List<Wisdom>();

  @override
  Stream<List<Wisdom>> mapEventToState(
    FavoriteEvent event,
  ) async* {
    List<Wisdom> newFavorites = new List()..addAll(currentState);

    if (event is AddFavoriteEvent) newFavorites.add(event.favorite);
    if (event is RemoveFavoriteEvent) newFavorites.remove(event.favorite);

    yield newFavorites;
  }
}
