import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wisgen/blocs/favorite_bloc.dart';
import 'package:wisgen/blocs/favorite_event.dart';
import 'package:wisgen/models/wisdom.dart';

import 'package:wisgen/repositories/storage.dart';
import 'package:wisgen/data/storage_shared_preference.dart';

enum StorageState {
  idle
} //Because this BLoC doesn't need to emit Sate, I used a Single Enum
enum StorageEvent {
  load,
  wipe
} //Only 2 events that both don't need to carry additional data

///The StorageBLoC is injected with a FavoriteBLoC on Creation.
///It subscribes to the FavoriteBLoC and writes the Favorite List
///to a given Storage device every time a new State is emitted by the FavoriteBLoC.
///
///When the StorageBLoC receives a load Event, it loads a list of Wisdoms from a given
///Storage device and pipes it into the FavoriteBLoC
///
///Used to keep a Persistent copy of the Favorite List on the Device
class StorageBloc extends Bloc<StorageEvent, StorageState> {
  Storage _storage = new SharedPreferenceStorage();
  FavoriteBloc _observedBloc;

  StorageBloc(this._observedBloc) {
    //Subscribe to BLoC
    _observedBloc.state.listen((state) async {
      await _storage.save(state);
    });
  }

  @override
  StorageState get initialState => StorageState.idle;

  @override
  Stream<StorageState> mapEventToState(StorageEvent event) async* {
    if (event == StorageEvent.load) await _load();
    if (event == StorageEvent.wipe) _storage.wipeStorage();
  }

  _load() async {
    List<Wisdom> loaded = await _storage.load();

    if (loaded == null || loaded.isEmpty) return;

    loaded.forEach((f) {
      _observedBloc.dispatch(AddFavoriteEvent(f));
    });
  }

  //Injection
  set storage(Storage storage) => _storage = storage;
  set observedBloc(FavoriteBloc observedBloc) => _observedBloc = observedBloc;
}
