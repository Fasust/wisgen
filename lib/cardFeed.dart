import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wisgen/data/wisdoms.dart';

import 'adviceCard.dart';
import 'data/advice.dart';
import 'data/stockImg.dart';
import 'loadingCard.dart';

class CardFeed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CardFeedState();
}

class CardFeedState extends State<CardFeed> {

  final _adviceURI = 'https://api.adviceslip.com/advice';
  final _imagesURI = 'https://source.unsplash.com/800x600/?';

  final _wisdomList = <Wisdom>[];

  final _random = new Random();


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          return FutureBuilder(
              future: _createWisdom(),
              builder: (context, wisdom) {
                if (wisdom.connectionState == ConnectionState.done) {
                  _wisdomList.add(wisdom.data);
                  return AdviceCard(wisdom: wisdom.data);
                } else {
                  return LoadingCard();
                }
              });
        });
  }

  Future<Advice> _fetchAdvice() async {
    final response = await http.get(_adviceURI);
    return Advice.fromJson(json.decode(response.body));
  }

  Future<StockImg> _fetchImage(String keyword) async {
    final String url = _imagesURI + keyword;
    final response = await http.get(url);
    final Uint8List imgBytes = response.bodyBytes;
    return StockImg(url, imgBytes);
  }

  Future<Wisdom> _createWisdom() async{
    final advice = await _fetchAdvice();

    //Calculating key word
    final List<String> dirtyWords = advice.text.split(new RegExp("[^a-zA-Z0-9]"));
    final List<String> words = new List();
    dirtyWords.forEach((s){
      if(s.isNotEmpty){
        words.add(s);
      }
    });
    final String keyword = words[next(0, words.length -1)];

    final img = await _fetchImage(keyword);
    return Wisdom(advice,img);
  }

  int next(int min, int max) => min + _random.nextInt(max - min);
}
