import 'dart:convert';
import 'dart:math';

import 'package:flutter/src/widgets/framework.dart';
import 'package:wisgen/models/advice_slips.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/repositories/repository.dart';
import 'package:http/http.dart' as http;

class AdviceSlipApi implements Repository<Wisdom> {
  static const _adviceURI = 'https://api.adviceslip.com/advice/search/%20';
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
    http.Response response = await http.get(_adviceURI);
    AdviceSlips adviceSlips = AdviceSlips.fromJson(json.decode(response.body));

    List<Wisdom> wisdoms = new List();
    adviceSlips.slips.forEach((slip) {
      wisdoms.add(slip.toWisdom());
    });

    return wisdoms;
  }
}
