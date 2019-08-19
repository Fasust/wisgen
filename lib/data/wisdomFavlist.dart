import 'package:flutter/material.dart';
import 'package:wisgen/data/wisdoms.dart';

/**
 * A List with an Attached ChangeNotifier
 * I am using this to access State in between different Widgets 
 * Shown in this Talk by google Engeniers: https://www.youtube.com/watch?v=d_m5csmrf7I
 */
class WisdomFavList with ChangeNotifier{
  final List<Wisdom> _entries  = new List();

  List<Wisdom> get() => _entries;
  bool contains(Wisdom wisdom) => _entries.contains(wisdom);

  void add(Wisdom wisdom){
    _entries.add(wisdom);
    notifyListeners();
  }
  void remove(Wisdom wisdom){
    _entries.remove(wisdom);
    notifyListeners();
  } 
}