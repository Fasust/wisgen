import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/repositories/storage.dart';

class SharedPreferenceStorage implements Storage<Wisdom> {
  static const String _sharedPrefKey = "wisgen_storage";

  @override
  Future<List<Wisdom>> load() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> strings = prefs.getStringList(_sharedPrefKey);

    log("got Prefs");
    if (strings == null || strings.isEmpty) return null;

    log("Prefs aint empty " + strings.length.toString());

    List<Wisdom> wisdoms = new List();
    strings.forEach((s) {
      debugPrint("read from Prefs: " + s);
      Wisdom w = Wisdom.fromJson(jsonDecode(s));
      log(w.toString());
      wisdoms.add(w);
    });
    return wisdoms;
  }

  @override
  save(List<Wisdom> data) async {
    if (data == null || data.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();

    List<String> strings = new List();
    data.forEach((wisdom) {
      strings.add(json.encode(wisdom.toJson()));
      log("wrote to Prefs: " + (jsonEncode(wisdom.toJson())));
    });

    prefs.setStringList(_sharedPrefKey, strings);
  }

  @override
  wipeStorage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_sharedPrefKey);
  }
}
