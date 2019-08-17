import 'package:flutter/foundation.dart';

class Advice {
  final String id;
  final String text;

  Advice({@required this.id,@required this.text});
  factory Advice.fromJson(Map<String, dynamic> json) {
    return Advice(id: json['slip']['slip_id'], text: json['slip']['advice']);
  }
}
