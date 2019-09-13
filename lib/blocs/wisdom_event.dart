import 'package:flutter/widgets.dart';

//The Wisdom BLoC ony has one type of event "fetch"
//When an event is dispatched we take in the Build Context incase 
//our Repositories (that fetch the data) need it
class FetchEvent{
  final BuildContext context;
  FetchEvent(this.context);
}