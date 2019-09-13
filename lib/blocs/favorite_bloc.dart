import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wisgen/models/wisdom.dart';

import 'favorite_event.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, List<Wisdom>> {
  @override
  List<Wisdom> get initialState => new List();

  @override
  Stream<List<Wisdom>> mapEventToState(
    FavoriteEvent event,
  ) async* {
    List<Wisdom> newState = new List()..addAll(currentState);

    if (event is AddFavoriteEvent) newState.add(event.favorite);

    if (event is RemoveFavoriteEvent) newState.remove(event.favorite);

    yield newState;
  }
}
