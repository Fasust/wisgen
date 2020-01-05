import 'package:flutter/widgets.dart';

///Holds one pice of supreme [Wisdom].
///
///[Wisdom.id] is only unique in the scope of its [Wisdom.type].
///[Wisdom.imgUrl] is not required on creation, but can be injected later.
///Can be converter to/ read from JSON.
///Can generate a sharable string with [Wisdom.shareAsString()] to be send
///as a share intend.
class Wisdom {
  final String text;
  final int id;
  final String type;
  String imgUrl;

  Wisdom({
    @required this.text,
    @required this.id,
    @required this.type,
    this.imgUrl,
  });

  @override
  String toString() => '$type: $id';

  Map<String, dynamic> toJson() => {
        'text': text,
        'id': '$id',
        'type': type,
        'imgURL': imgUrl,
      };

  Wisdom.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id']),
        text = json['text'],
        type = json['type'],
        imgUrl = json['imgURL'];

  String shareAsString() =>
      "Check out this peace of Wisdom I found using Wisgen 🔮:\n\n" 
      "\"" +
      text +
      "\"\n\n" 
      "Related Image: \n\n" +
      imgUrl +
      "\n\n... Pretty Deep 🤔";
}
