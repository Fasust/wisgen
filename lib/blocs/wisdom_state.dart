import 'package:meta/meta.dart';
import 'package:wisgen/models/wisdom.dart';

//The Wisdom BLoC has 2 States: Loaded and Error
//We can infer it is loading when we are not reviving new items through the stream
@immutable
abstract class WisdomState {}

//Broadcasted om Network Error
class ErrorWisdomState extends WisdomState {
  final Exception exception;

  ErrorWisdomState(this.exception);
}

//The state that Carries the Fetched Wisdoms
class LoadedWisdomState extends WisdomState {
  final List<Wisdom> wisdoms;

  LoadedWisdomState(this.wisdoms);
}
