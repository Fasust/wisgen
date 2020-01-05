import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wisgen/models/wisdom.dart';

@immutable
abstract class WisdomState extends Equatable {}

///Broadcasted from [WisdomBloc] on Network Error.
@immutable
class WisdomStateError extends WisdomState {
  final Exception exception;
  WisdomStateError(this.exception);

  @override
  List<Object> get props => [exception];

   @override
  String toString() => 'Error/${exception.toString()}';
}

///Gives Access to current list of [Wisdom] s in the [WisdomBloc].
///
///When BLoC receives a [WisdomEventFetch] during this State, 
///it fetches more [Wisdom] from it [Supplier]. 
///When done it emits a new [IdleSate] with more [Wisdom].
@immutable
class WisdomStateIdle extends WisdomState {
  final List<Wisdom> wisdoms;
  WisdomStateIdle(this.wisdoms);

  @override
  List<Object> get props => wisdoms;

   @override
  String toString() => 'Idle/With ${wisdoms.length} wisdoms';
}


