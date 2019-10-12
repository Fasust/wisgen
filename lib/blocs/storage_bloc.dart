import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wisgen/blocs/favorite_bloc.dart';
import 'package:wisgen/blocs/favorite_event.dart';
import 'package:wisgen/models/wisdom.dart';

import 'package:wisgen/repositories/storage.dart';
import 'package:wisgen/data/shared_preference_storage.dart';

///Gives access to the 2 events the [StorageBloc] can receive.
///
///It is an enum, because the 2 events both don't need to carry additional data
///[StorageEvent.load] tells the [StorageBloc] to load the 
///favorite list from it [Storage]
///[StorageEvent.wipe] tells the [StorageBloc] to wipe 
///any favorites on the [Storage]
enum StorageEvent { load, wipe }

///Responsible for keeping a persistent copy of the favorite list 
///on it's [Storage].
///
///It is injected with a [FavoriteBLoC] on Creation.
///It subscribes to the [FavoriteBLoC] and writes the favorite list to a 
///its [Storage] device every time a new State is emitted by the [FavoriteBLoC].
///When the [StorageBLoC] receives a StorageEvent.load, it loads a list of [Wisdom]s 
///from a its [Storage] device and pipes it into the [FavoriteBLoC] though [FavoriteEventAdd]s
///(This usually happens once on Start-up).
///It's State is [dynamic] because it never needs to emit it.
class StorageBloc extends Bloc<StorageEvent, dynamic> {
  Storage _storage = SharedPreferenceStorage();
  FavoriteBloc _observedBloc;

  StorageBloc(this._observedBloc) {
    //Subscribe to BLoC
    _observedBloc.state.listen((state) async {
      await _storage.save(state);
    });
  }

  @override
  dynamic get initialState => dynamic;

  @override
  Stream<dynamic> mapEventToState(StorageEvent event) async* {
    if (event == StorageEvent.load) await _load();
    if (event == StorageEvent.wipe) _storage.wipeStorage();
  }

  _load() async {
    List<Wisdom> loaded = await _storage.load();

    if (loaded == null || loaded.isEmpty) return;

    loaded.forEach((f) {
      _observedBloc.dispatch(FavoriteEventAdd(f));
    });
  }

  //Injection ---
  set storage(Storage storage) => _storage = storage;
  set observedBloc(FavoriteBloc observedBloc) => _observedBloc = observedBloc;
}
