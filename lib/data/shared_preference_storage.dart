import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/repositories/storage.dart';

///[Storage] that gives access to Androids Shared Preferences 
///(a small, local, persistent key value store).
class SharedPreferenceStorage implements Storage<List<Wisdom>> {
  ///Key is used to access store
  static const String _sharedPrefKey = "wisgen_storage";

  @override
  Future<List<Wisdom>> load() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> strings = prefs.getStringList(_sharedPrefKey);

    if (strings == null || strings.isEmpty) return null;

    //Decode all JSON Strings we fetched from the Preferences and add them to the Result
    List<Wisdom> wisdoms = List();
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

    //Encode data to JSON Strings
    List<String> strings = List();
    data.forEach((wisdom) {
      strings.add(json.encode(wisdom.toJson()));
    });

    //Overwrite Preferences with new List
    prefs.setStringList(_sharedPrefKey, strings);
  }

  @override
  wipeStorage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_sharedPrefKey);
  }
}
