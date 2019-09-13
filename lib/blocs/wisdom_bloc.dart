import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wisgen/blocs/wisdom_state.dart';
import 'package:wisgen/models/wisdom.dart';

enum WisdomEvent { fetch }

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
        final wisdoms = _fetch(_fetchAmount);
        yield LoadedWisdomState(
            (currentState as LoadedWisdomState).wisdoms + wisdoms);
      }
    } catch (e) {
      yield ErrorWisdomState(e);
    }
  }

  List<Wisdom> _fetch(int amount) {
    List<Wisdom> res = new List();
    for (int i = 0; i < amount; i++) {
      res.add(new Wisdom(
          text: "Test",
          id: i,
          type: "type",
          imgURL:
              "https://images.unsplash.com/photo-1567103477235-e34a3d5da8a2?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=600&ixlib=rb-1.2.1&q=80&w=800"));
    }
    return res;
  }
}
