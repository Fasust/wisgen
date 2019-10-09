import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wisgen/models/wisdom.dart';

///The Wisdom BLoC has 2 States: Loaded and Error
///We can infer it is loading when we are not reviving new items through the stream
@immutable
abstract class WisdomState extends Equatable {}

///Broadcasted on Network Error
class ErrorWisdomState extends WisdomState {
  final Exception exception;
  ErrorWisdomState(this.exception);

  @override
  List<Object> get props => [exception];
}

///Normal State that holds favorite list.
///When BLoC receives a FetchEvent during this State, 
///it fetched more wisdom and emits a new IdleSate 
///with more wisdoms
class IdleWisdomState extends WisdomState {
  final List<Wisdom> wisdoms;
  IdleWisdomState(this.wisdoms);

  @override
  List<Object> get props => wisdoms;
}


