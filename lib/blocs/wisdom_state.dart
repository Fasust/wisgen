import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wisgen/models/wisdom.dart';

///The Wisdom BLoC has 2 States: Loaded and Error
///We can infer it is loading when we are not reviving new items through the stream
@immutable
abstract class WisdomState extends Equatable {}

///Broadcasted on Network Error
class WisdomStateError extends WisdomState {
  final Exception exception;
  WisdomStateError(this.exception);

  @override
  List<Object> get props => [exception];
}

///Normal State that holds favorite list.
///When BLoC receives a FetchEvent during this State, 
///it fetched more wisdom and emits a new IdleSate 
///with more wisdoms
class WisdomStateIdle extends WisdomState {
  final List<Wisdom> wisdoms;
  WisdomStateIdle(this.wisdoms);

  @override
  List<Object> get props => wisdoms;
}


