import 'package:flutter/widgets.dart';

///Tells the [WisdomBloc] to fetch more [Wisdom]s when dispatched.
///
///Some sources of [Wisdom] may need a [BuildContext] to be
///accessed, that's why it's a parameter.
class WisdomEventFetch{
  final BuildContext context;
  WisdomEventFetch(this.context);
}