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
}
