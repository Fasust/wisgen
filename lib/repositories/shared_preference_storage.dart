import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/repositories/storage.dart';

class SharedPreferenceStorage implements Storage<Wisdom> {
  static const String _sharedPrefKey = "wisgen_storage";

  @override
  Future<List<Wisdom>> load() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> strings = prefs.getStringList(_sharedPrefKey);

    if (strings == null || strings.isEmpty) return null;

    List<Wisdom> wisdoms = new List();
    strings.forEach((s) {
      Wisdom w = Wisdom.fromJson(jsonDecode(s));

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
    });

    prefs.setStringList(_sharedPrefKey, strings);
  }

  @override
  wipeStorage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_sharedPrefKey);
  }
}
