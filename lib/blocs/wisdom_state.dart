import 'package:meta/meta.dart';
import 'package:wisgen/models/wisdom.dart';

@immutable
abstract class WisdomState {}

class ErrorWisdomState extends WisdomState {
  final Exception exception;

  ErrorWisdomState(this.exception);
}

class LoadedWisdomState extends WisdomState {
  final List<Wisdom> wisdoms;

  LoadedWisdomState(this.wisdoms);
}
