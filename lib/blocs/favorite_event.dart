import 'package:meta/meta.dart';
import 'package:wisgen/models/wisdom.dart';

///The Favorite BLoC can handle 2 types of Events: Add and Remove.
///These events add and remove Wisdoms from the Favorite List respectively.
@immutable
abstract class FavoriteEvent {
  final Wisdom _favorite;
  get favorite => _favorite;

  FavoriteEvent(this._favorite);
}

class FavoriteEventAdd extends FavoriteEvent {
  FavoriteEventAdd(Wisdom favorite) : super(favorite);
}

class FavoriteEventRemove extends FavoriteEvent {
  FavoriteEventRemove(Wisdom favorite) : super(favorite);
}
