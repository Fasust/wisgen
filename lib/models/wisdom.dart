import 'package:flutter/widgets.dart';

class Wisdom {
  final String text;
  final int id;
  final String type;
  String imgURL;

  Wisdom({
    @required this.text,
    @required this.id,
    @required this.type,
    this.imgURL,
  });

  @override
  String toString() {
    return '$id' + ": " + text;
  }

  Map<String, dynamic> toJson() => {
        'wisdom': {'text': text, 'id': id, 'type': type, 'imgURL': imgURL}
      };

  Wisdom.fromJson(Map<String, dynamic> json)
      : this.id = json['wisdom']['id'],
        this.text = json['wisdom']['text'],
        this.type = json['wisdom']['type'],
        this.imgURL = json['wisdom']['imgURL'];
}
