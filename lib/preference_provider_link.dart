import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisgen/jsonable.dart';
import 'package:wisgen/provider/providable.dart';

class PreferenceProviderLink<ProviderClass extends Providable>{
  final String _sharedPrefKey;
  Jsonable _jsonable;

  PreferenceProviderLink(this._sharedPrefKey, this._jsonable);

  void readPrefs(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> strings = prefs.getStringList(_sharedPrefKey);

    if (strings == null || strings.isEmpty) {
      return;
    }

    for (int i = 0; i < strings.length; i++) {
      Provider.of<ProviderClass>(context).add(_jsonable.fromString(strings[i]));
    }
  }

  void writePrefs(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    ProviderClass provider = Provider.of<ProviderClass>(context);
    List<String> strings = new List();
    for (int i = 0; i < provider.length(); i++) {
      strings.add(provider.getAt(i).toString());
    }
    prefs.setStringList(_sharedPrefKey, strings);
  }

  void deletePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_sharedPrefKey);
  }

}
