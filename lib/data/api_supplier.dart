import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wisgen/models/advice_slips.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/repositories/supplier.dart';
import 'package:http/http.dart' as http;

///[Supplier] that cashes [Wisdom]s it fetches from an API and
///then provides a given amount of random entries.
///
///[Wisdom]s Supplies do not have an Image URL
class ApiSupplier implements Supplier<List<Wisdom>> {
  ///Advice SLip API Query that requests all (~213) Text Entries from the API.
  //////We fetch all entries at once and cash them locally to minimize network traffic.
  ///The Advice Slip API also does not provide the option to request a selected amount of entries.
  ///That's why I think this is the best approach.
  static const _adviceURI = 'https://api.adviceslip.com/advice/search/%20';
  List<Wisdom> _cash;
  final Random _random = Random();

  @override
  Future<List<Wisdom>> fetch(int amount, BuildContext context) async {
    //if the Cash is empty, request data from the API
    if (_cash == null) _cash = await _loadData();

    List<Wisdom> res = List();
    for (int i = 0; i < amount; i++) {
      res.add(_cash[_random.nextInt(_cash.length)]);
    }
    return res;
  }

  ///Fetches Data from API and coverts it to Wisdoms
  Future<List<Wisdom>> _loadData() async {
    http.Response response = await http.get(_adviceURI);
    AdviceSlips adviceSlips = AdviceSlips.fromJson(json.decode(response.body));

    List<Wisdom> wisdoms = List();
    adviceSlips.slips.forEach((slip) {
      wisdoms.add(slip.toWisdom());
    });

    return wisdoms;
  }
}
