import 'package:flutter_test/flutter_test.dart';
import 'package:wisgen/blocs/favorite_bloc.dart';
import 'package:wisgen/blocs/favorite_event.dart';
import 'package:wisgen/models/wisdom.dart';

void main() {

  ///Related test are grouped together 
  ///to get a more readable output 
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
    
    test('Add a Favorite and see if it is emitted as state', () {
      Wisdom wisdom = Wisdom(id: 1, text: "Back up your Pictures", type: "tech");
      favoriteBloc.dispatch(AddFavoriteEvent(wisdom));
      favoriteBloc.state.listen((data) => () {
            expect(wisdom, data);
          });
    });

    test('Add and Remove a Favorite and see if the state is empty', () {
      Wisdom wisdom = Wisdom(id: 1, text: "Back up your Pictures", type: "tech");
      favoriteBloc.dispatch(AddFavoriteEvent(wisdom));
      favoriteBloc.dispatch(RemoveFavoriteEvent(wisdom));
      expect(0, favoriteBloc.currentState.length);
    });

    test('Stream many events and see if the State is emitted in correct order', () {
      Wisdom wisdom1 = Wisdom(id: 1, text: "Back up your Pictures", type: "tech");
      Wisdom wisdom2 = Wisdom(id: 2, text: "Wash your ears", type: "Mum's Advice");
      Wisdom wisdom3 = Wisdom(id: 3, text: "Travel while you're young", type: "Grandma's Advice");

      favoriteBloc.dispatch(AddFavoriteEvent(wisdom1));
      favoriteBloc.dispatch(AddFavoriteEvent(wisdom2));
      favoriteBloc.dispatch(RemoveFavoriteEvent(wisdom1));
      favoriteBloc.dispatch(AddFavoriteEvent(wisdom3));

      expect(
          favoriteBloc.state,
          emitsInOrder([
            List(), //BLoC Library BLoCs emit their initial State on creation
            List()..add(wisdom1),
            List()..add(wisdom1)..add(wisdom2),
            List()..add(wisdom2),
            List()..add(wisdom2)..add(wisdom3)
          ]));
    });
  });
}
