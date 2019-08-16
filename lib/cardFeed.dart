import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'adviceCard.dart';
import 'data/advice.dart';

class CardFeed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CardFeedState();
}

class CardFeedState extends State<CardFeed> {
  static const _adviceURI = 'https://api.adviceslip.com/advice';
  static const _imagesURI = 'https://picsum.photos/v2/list?page=1&limit=100';
  final _adviveList = <Advice>[];

  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, i) {
      return FutureBuilder(
          future: _fetchAdvice(),
          builder: (context, advice) {
            if (advice.connectionState == ConnectionState.done) {
              _adviveList.add(advice.data);
              return _buildCard(advice.data);
            } else {
              return Align(
                  alignment: Alignment.topCenter,
                  child: CircularProgressIndicator());
            }
          });
    });
  }

  Future<Advice> _fetchAdvice() async {
    final response = await http.get(_adviceURI);
    return Advice.fromJson(json.decode(response.body));
  }


  AdviceCard _buildCard(Advice a) {
    return AdviceCard(id: a.id, adviceText: a.text);
  }
}
