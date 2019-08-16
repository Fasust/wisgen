import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CardFeed extends StatelessWidget {
  static const _adviceURI = 'https://api.adviceslip.com/advice';
  static const _imageURI = 'https://picsum.photos/200';

  final _adviveList = <Advice>[];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Advice>(
      future: fetchAdvice(),
      builder: (context, advice) {
        if (advice.hasData) {
          return Text(advice.data.text);
        } else if (advice.hasError) {
          return Text("${advice.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }

  Future<Advice> fetchAdvice() async {
    final response = await http.get(_adviceURI);
    return Advice.fromJson(json.decode(response.body));
  }

}
class Advice{
  final String id;
  final String text;

  Advice(this.id, this.text);
  factory Advice.fromJson(Map<String, dynamic> json) {
    return Advice(
      json['slip']['slip_id'],
      json['slip']['advice']
    );
  }

}
