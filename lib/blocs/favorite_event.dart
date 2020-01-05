import 'package:meta/meta.dart';
import 'package:wisgen/models/wisdom.dart';

@immutable
abstract class FavoriteEvent {
  final Wisdom _favorite;
  get favorite => _favorite;

  FavoriteEvent(this._favorite);
}

///Adds a given [Wisdom] to the [FavoriteBloc] when dispatched
@immutable
class FavoriteEventAdd extends FavoriteEvent {
  FavoriteEventAdd(Wisdom favorite) : super(favorite);
}

///Removes a given [Wisdom] from the [FavoriteBloc] when dispatched
@immutable
class FavoriteEventRemove extends FavoriteEvent {
  FavoriteEventRemove(Wisdom favorite) : super(favorite);
}
