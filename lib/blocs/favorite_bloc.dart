import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wisgen/models/wisdom.dart';

import 'favorite_event.dart';

///Responsible for keeping track of the Favorite List. 
///
///Receives [FavoriteEvent] to add/remove favorite [Wisdom] objects 
///from its list.
///Broadcasts complete list of favorites every time it changes.
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
