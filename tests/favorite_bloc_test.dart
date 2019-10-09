import 'package:flutter_test/flutter_test.dart';
import 'package:wisgen/blocs/favorite_bloc.dart';
import 'package:wisgen/blocs/favorite_event.dart';
import 'package:wisgen/models/wisdom.dart';

void main() {
  group('Favorite Bloc', () {
    FavoriteBloc favoriteBloc;

    setUp((){
      //Run before each test
      favoriteBloc = new FavoriteBloc();
    });

    tearDown((){
      //Run after each test
      favoriteBloc.dispose();
    });
    
    test('Add a Favorite and see if it is emitted by th BLoC', () {
      Wisdom wisdom = Wisdom(id: 1, text: "Wisdom", type: "any");
      favoriteBloc.dispatch(AddFavoriteEvent(wisdom));
      favoriteBloc.state.listen((data) => () {
            expect(wisdom, data);
          });
    });

    test('Add and Remove a Favorite and see if the BLoC is empty', () {
      Wisdom wisdom = Wisdom(id: 1, text: "Wisdom", type: "any");
      favoriteBloc.dispatch(AddFavoriteEvent(wisdom));
      favoriteBloc.dispatch(RemoveFavoriteEvent(wisdom));
      expect(0, favoriteBloc.currentState.length);
    });

    test('Stream many events and see if BLoC emits State in correct order', () {
      Wisdom wisdom1 = Wisdom(id: 1, text: "Wisdom", type: "any");
      Wisdom wisdom2 = Wisdom(id: 2, text: "Wisdom", type: "any");
      Wisdom wisdom3 = Wisdom(id: 3, text: "Wisdom", type: "any");

      favoriteBloc.dispatch(AddFavoriteEvent(wisdom1));
      favoriteBloc.dispatch(AddFavoriteEvent(wisdom2));
      favoriteBloc.dispatch(RemoveFavoriteEvent(wisdom1));
      favoriteBloc.dispatch(AddFavoriteEvent(wisdom3));

      expect(
          favoriteBloc.state,
          emitsInOrder([
            List(),
            List()..add(wisdom1),
            List()..add(wisdom1)..add(wisdom2),
            List()..add(wisdom2),
            List()..add(wisdom2)..add(wisdom3)
          ]));
    });
  });
}
