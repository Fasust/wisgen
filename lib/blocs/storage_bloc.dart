import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wisgen/blocs/favorite_event.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/repositories/shared_preference_storage.dart';
import 'package:wisgen/repositories/storage.dart';

enum StorageState { idle }
enum StorageEvent { load, wipe }

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  final Storage _storage = new SharedPreferenceStorage();
  final Bloc _observedBloc;

  StorageBloc(this._observedBloc) {
    _observedBloc.state.listen((state) async {
      await _storage.save(state);
    });
  }

  @override
  StorageState get initialState => StorageState.idle;

  @override
  Stream<StorageState> mapEventToState(
    StorageEvent event,
  ) async* {
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

}
