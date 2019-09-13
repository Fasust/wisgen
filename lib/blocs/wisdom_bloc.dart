import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wisgen/blocs/wisdom_state.dart';
import 'package:wisgen/models/wisdom.dart';

//This Bloc Only has a Single Event, which causes the BLoC to fetch more Data
//I am using Enum incase I want to add more events in the Future
enum WisdomEvent { fetch }

//This BLoC Is Responsible for Fetching Wisdoms from a given Source (Repository)
//It Fetches Wisdoms in batches of 20 and Broadcasts th complete List
class WisdomBloc extends Bloc<WisdomEvent, WisdomState> {
  static const int _fetchAmount = 20;
  @override
  WisdomState get initialState => LoadedWisdomState(new List());

  @override
  Stream<WisdomState> mapEventToState(
    WisdomEvent event,
  ) async* {
    try {
      if (currentState is LoadedWisdomState) {
        final wisdoms = await _fetch(_fetchAmount);
        yield LoadedWisdomState(
            (currentState as LoadedWisdomState).wisdoms + wisdoms); //Appending the new Wisdoms to the current state
      }
    } catch (e) {
      yield ErrorWisdomState(e);
    }
  }

  //Dummy API call
  Future<List<Wisdom>> _fetch(int amount) async {
    List<Wisdom> res = new List();
    for (int i = 0; i < amount; i++) {
      res.add(new Wisdom(
          text: "Test",
          id: i,
          type: "type",
          imgURL:
              "https://images.unsplash.com/photo-1567103477235-e34a3d5da8a2?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=600&ixlib=rb-1.2.1&q=80&w=800"));
    }
    await Future.delayed(Duration(milliseconds: 500));
    return res;
  }
}
