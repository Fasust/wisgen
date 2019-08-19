import 'package:flutter/foundation.dart';

/**
 * An Advice consist of a text and an non unique ID
 */
class Advice {
  final String id;
  final String text;

  Advice({@required this.id,@required this.text});
  factory Advice.fromJson(Map<String, dynamic> json) {
    return Advice(id: json['slip']['slip_id'], text: json['slip']['advice']);
  }
}
