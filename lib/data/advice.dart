import 'package:flutter/foundation.dart';

/**
 * An Advice consist of a text and an non unique ID
 */
class Advice {
  final String id;
  final String text;
  final String type;
  static const String defaultType = 'Advice';

  Advice({@required this.id, @required this.text, this.type});
  factory Advice.fromJson(Map<String, dynamic> json) {
    return Advice(id: json['slip']['slip_id'], text: json['slip']['advice'], type: defaultType);
  }
}
