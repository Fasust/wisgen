import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';

class Wisdom {
  final String text;
  final int id;
  final String imgURL;
  final String type;

  Wisdom(
      {@required this.text,
      @required this.id,
      @required this.imgURL,
      @required this.type});

  @override
  String toString() {
    return '$id' + ": " + text;
  }
}
