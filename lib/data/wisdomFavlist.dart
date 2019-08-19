import 'package:flutter/material.dart';
import 'package:wisgen/data/wisdoms.dart';

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