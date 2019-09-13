import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/repositorys/repository.dart';

class LocalWisdomRepository implements Repository<Wisdom> {
  static const _path = './assets/advice.txt';
  List<Wisdom> _buffer;
  Random _random = new Random();

  @override
  Future<List<Wisdom>> fetch(int amount, BuildContext context) async {
    if (_buffer == null) _buffer = await loadDataToBuffer(context);

    List<Wisdom> res = new List();
    for (int i = 0; i < amount; i++) {
      res.add(_buffer[_random.nextInt(_buffer.length)]);
    }
    return res;
  }

  Future<List<Wisdom>> loadDataToBuffer(BuildContext context) async {
    String localAdvice = await DefaultAssetBundle.of(context).loadString(_path);
    List<String> strings = localAdvice.split('\n');
    List<Wisdom> wisdoms = new List();

    String currentType;
    int relativeIndex;

    for (int i = 0; i < strings.length; i++) {
      if (strings[i].startsWith('#')) {
        //new type of wisdom
        strings[i] = strings[i].substring(2);
        currentType = strings[i];
        relativeIndex = 1;
        continue; //do not add type header
      }
      wisdoms.add(
          new Wisdom(id: relativeIndex, text: strings[i], type: currentType));
      relativeIndex++;
    }
    return wisdoms;
  }
}
