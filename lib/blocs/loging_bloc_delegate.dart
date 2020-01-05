import 'package:bloc/bloc.dart';

///Logs all state transitions and errors of [Bloc]s
class LogingBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    String blocName = bloc.runtimeType.toString();
    String currentState = transition.currentState is List
        ? transition.currentState.length.toString()
        : transition.currentState.toString();
    String eventName = transition.event.toString();
    String nextState = transition.nextState is List
        ? transition.nextState.length.toString()
        : transition.nextState.toString();

    String message = blocName +
        ':\t' +
        currentState +
        ' + ' +
        eventName +
        ' -> ' +
        nextState;

    printWrapped(message);

    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    print(bloc.runtimeType.toString() + ':\t' + error.toString());
    super.onError(bloc, error, stacktrace);
  }

  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
