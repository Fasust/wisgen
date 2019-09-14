import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:wisgen/blocs/favorite_bloc.dart';
import 'package:wisgen/blocs/favorite_event.dart';
import 'package:wisgen/blocs/storage_event.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/repositories/shared_preference_storage.dart';
import 'package:wisgen/repositories/storage.dart';

enum StorageState { idle }

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  final Storage _storage = new SharedPreferenceStorage();
  final FavoriteBloc _favoriteBloc;

  StorageBloc(this._favoriteBloc){
    _favoriteBloc.state.listen((_){
      this.dispatch(StoreEvent());
    });
  }

  @override
  StorageState get initialState => StorageState.idle;

  @override
  Stream<StorageState> mapEventToState(
    StorageEvent event,
  ) async* {
    log(event.toString());
    if (event is LoadEvent) yield await _loadStoredFavorites();
    if (event is StoreEvent) yield await _saveFavorites();
  }

  Future<StorageState> _loadStoredFavorites() async {
    List<Wisdom> loadedFavs = await _storage.load();

    if (loadedFavs == null || loadedFavs.isEmpty) return StorageState.idle;

    loadedFavs.forEach((f) {
      _favoriteBloc.dispatch(AddFavoriteEvent(f));
    });

    return StorageState.idle;
  }

  Future<StorageState> _saveFavorites() async {
    List<Wisdom> favorites = await _favoriteBloc.state.last;
    await _storage.save(favorites);

    return StorageState.idle;
  }
}
