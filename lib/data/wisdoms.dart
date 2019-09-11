import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:wisgen/data/advice.dart';
import 'package:wisgen/tools/jsonable.dart';

/**
 * Data Structure that combines an shockImg and and an Advice to form a "Wisdom"
 * It can be read from a JSON or returned as a JSON
 */
class Wisdom extends Jsonable {
  final Advice advice;
  final String stockImURL;
  

  Wisdom(this.advice, this.stockImURL);

  @override
  Map<String, dynamic> toJson() => {
        'advice': {
          'text': advice.text,
          'id': advice.id,
          'type': advice.type != null ? advice.type : Advice.defaultType
        },
        'stockImURL': stockImURL,
      };

  @override
  Jsonable fromJson(Map<String, dynamic> json) {
    return Wisdom(
        new Advice(
            text: json['advice']['text'],
            id: json['advice']['id'],
            type: json['advice']['type'] != null
                ? json['advice']['type']
                : Advice.defaultType),
        json['stockImURL']);
  }
}
