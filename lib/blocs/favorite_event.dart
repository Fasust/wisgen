import 'package:meta/meta.dart';
import 'package:wisgen/models/wisdom.dart';

@immutable
abstract class FavoriteEvent {
  final Wisdom _favorite;
  get favorite => _favorite;

  FavoriteEvent(this._favorite);
}

class AddFavoriteEvent extends FavoriteEvent {
  AddFavoriteEvent(Wisdom favorite) : super(favorite);
}

class RemoveFavoriteEvent extends FavoriteEvent {
  RemoveFavoriteEvent(Wisdom favorite) : super(favorite);
}
