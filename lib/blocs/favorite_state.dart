import 'package:meta/meta.dart';
import 'package:wisgen/models/wisdom.dart';

@immutable
abstract class FavoriteState {
  final List<Wisdom> favorites;

  FavoriteState(this.favorites);
}

class InitialFavoriteState extends FavoriteState {
  InitialFavoriteState() : super(new List());
}

class IdleFavoriteState extends FavoriteState {
  IdleFavoriteState(List<Wisdom> favorites) : super(favorites);
}
