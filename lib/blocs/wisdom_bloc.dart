import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wisgen/blocs/wisdom_event.dart';
import 'package:wisgen/blocs/wisdom_state.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/repositories/repository.dart';
import 'package:wisgen/repositories/repository_local.dart';

///This BLoC Is Responsible for Fetching Wisdoms from a given Source (Repository)
///It then Generates an IMG URL and appends it to the Wisdom
///It Fetches Wisdoms in batches of 20 and Broadcasts the complete List
class WisdomBloc extends Bloc<FetchEvent, WisdomState> {
  //Fetching Wisdom
  static const int _fetchAmount = 20;
  final Repository _repository = LocalRepository();

  //URI Generation
  static const int _minQueryWordLength = 4;
  final RegExp _nonLetterPattern = new RegExp("[^a-zA-Z0-9]");
  static const _imagesURI = 'https://source.unsplash.com/800x600/?';

  @override
  WisdomState get initialState => LoadedWisdomState(new List());

  @override
  Stream<WisdomState> mapEventToState(FetchEvent event) async* {
    try {
      if (currentState is LoadedWisdomState) {
        final List<Wisdom> wisdoms =
            await _repository.fetch(_fetchAmount, event.context);

        //Append the Img URLs
        wisdoms.forEach((w) {
          w.imgURL = _generateImgURL(w);
        });

        yield LoadedWisdomState((currentState as LoadedWisdomState).wisdoms +
            wisdoms); //Appending the new Wisdoms to the current state
      }
    } catch (e) {
      yield ErrorWisdomState(e);
    }
  }

  //URI Generation ---
  String _generateImgURL(Wisdom wisdom) {
    return _imagesURI + _stringToQuery(wisdom.text);
  }

  String _stringToQuery(String input) {
    final List<String> dirtyWords = input.split(_nonLetterPattern);
    String query = "";
    dirtyWords.forEach((w) {
      if (w.isNotEmpty && w.length >= _minQueryWordLength) {
        query += w + ",";
      }
    });
    return query;
  }
}
