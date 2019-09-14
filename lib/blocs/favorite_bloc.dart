import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:wisgen/blocs/favorite_state.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/repositories/shared_preference_storage.dart';
import 'package:wisgen/repositories/storage.dart';

import 'favorite_event.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  Storage _storage = new SharedPreferenceStorage();

  @override
  FavoriteState get initialState => InitialFavoriteState();

  @override
  Stream<FavoriteState> mapEventToState(
    FavoriteEvent event,
  ) async* {
    log(currentState.toString());

    if (currentState is InitialFavoriteState)
      yield await _loadStoredFavorites();

    yield await _updateFavorites(event);
  }

  Future<FavoriteState> _updateFavorites(FavoriteEvent event) async {
    List<Wisdom> newFavs = new List()..addAll(currentState.favorites);

    if (event is AddFavoriteEvent) newFavs.add(event.favorite);
    if (event is RemoveFavoriteEvent) newFavs.remove(event.favorite);

    _storage.save(newFavs);

    return IdleFavoriteState(newFavs);
  }

  Future<FavoriteState> _loadStoredFavorites() async {
    List<Wisdom> loadedFavs = await _storage.load();

    if (loadedFavs == null) loadedFavs = new List();

    log("Loaded: " + "${loadedFavs.length}" + " new Favs");
    return IdleFavoriteState(loadedFavs);
  }
}
