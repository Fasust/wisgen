import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wisgen/blocs/wisdom_event.dart';
import 'package:wisgen/blocs/wisdom_state.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/repositorys/local_wisdom_repository.dart';
import 'package:wisgen/repositorys/repository.dart';

//This BLoC Is Responsible for Fetching Wisdoms from a given Source (Repository)
//It Fetches Wisdoms in batches of 20 and Broadcasts th complete List
class WisdomBloc extends Bloc<FetchEvent, WisdomState> {
  static const int _fetchAmount = 20;
  final Repository _repository = LocalWisdomRepository();

  @override
  WisdomState get initialState => LoadedWisdomState(new List());

  @override
  Stream<WisdomState> mapEventToState(
    FetchEvent event,
  ) async* {
    try {
      if (currentState is LoadedWisdomState) {
        final wisdoms = await _repository.fetch(_fetchAmount,event.context);

        wisdoms.forEach((w){
          w.imgURL = "https://images.unsplash.com/photo-1567494129040-3d43ce89b279?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=600&ixlib=rb-1.2.1&q=80&w=800";
        });
        
        yield LoadedWisdomState(
            (currentState as LoadedWisdomState).wisdoms + wisdoms); //Appending the new Wisdoms to the current state
      }
    } catch (e) {
      yield ErrorWisdomState(e);
    }
  }
}
