import 'package:flutter/widgets.dart';

class Wisdom {
  final String text;
  final int id;
  final String type;
  final String imgURL;

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
        'text': text,
        'id': '$id',
        'type': type,
        'imgURL': imgURL,
      };

  Wisdom.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id']),
        text = json['text'],
        type = json['type'],
        imgURL = json['imgURL'];
}
