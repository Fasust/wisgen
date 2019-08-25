import 'package:flutter/cupertino.dart';

/**
 * A List with an Attached ChangeNotifier
 * I am using this to access State in between different Widgets 
 * Shown in this Talk by google Engeniers: https://www.youtube.com/watch?v=d_m5csmrf7I
 */
abstract class Providable<T> with ChangeNotifier{
  final List<T> _entries  = new List();

  List<T> get() => _entries;
  int length() => _entries.length;
  T getAt(int i) => _entries[i];
  bool contains(T t) => _entries.contains(t);

  void add(T t){
    _entries.add(t);
    notifyListeners();
  }
  void remove(T t){
    _entries.remove(t);
    notifyListeners();
  } 
  void removeAt(int i){
    _entries.removeAt(i);
    notifyListeners();
  }
}