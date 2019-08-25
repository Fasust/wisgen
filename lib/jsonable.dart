import 'dart:convert';

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
