import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/repositories/storage.dart';
import 'package:wisgen/repositories/storage_shared_preference.dart';

import 'favorite_event.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, List<Wisdom>> {
  Storage _storage = new SharedPreferenceStorage();

  @override
  List<Wisdom> get initialState => List<Wisdom>();

  @override
  Stream<List<Wisdom>> mapEventToState(
    FavoriteEvent event,
  ) async* {
  
    yield await _updateFavorites(event);
  }

  Future<List<Wisdom>> _updateFavorites(FavoriteEvent event) async {
    List<Wisdom> newFavs = new List()..addAll(currentState);

    if (event is AddFavoriteEvent) newFavs.add(event.favorite);
    if (event is RemoveFavoriteEvent) newFavs.remove(event.favorite);

    _storage.save(newFavs);

    return newFavs;
  }
}
