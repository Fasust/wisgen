import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:wisgen/data/advice.dart';

/**
 * Data Structure that combines an shockImg and and an Advice to form a "Wisdom"
 */
class Wisdom {
  final Advice advice;
  final String stockImURL;

  Wisdom(this.advice, this.stockImURL);

  @override
  String toString(){
    return jsonEncode(this.toJson());
  }

  Map<String, dynamic> toJson() => {
        'advice': {'text': advice.text, 'id': advice.id},
        'stockImURL': stockImURL,
      };

  static Wisdom fromString(String string) {
    return Wisdom.fromJson(json.decode(string));
  }

  Wisdom.fromJson(Map<String, dynamic> json)
      : advice =
            new Advice(text: json['advice']['text'], id: json['advice']['id']),
        stockImURL = json['stockImURL'];
}
