import 'dart:convert';

/**
 * Provides all functions necessary for 
 * an Object to be read as and turned into a JSON
 * 
 * Sadly the fromJson() & fromString() functions can not be static, 
 * as their behavior still needs to be defined in the child class
 */
abstract class Jsonable {
  @override
  String toString() {
    return jsonEncode(this.toJson());
  }

  Jsonable fromString(String string) {
    return fromJson(json.decode(string));
  }

  Map<String, dynamic> toJson();
  Jsonable fromJson(Map<String, dynamic> json);
}
