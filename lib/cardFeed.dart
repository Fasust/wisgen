import 'dart:convert';
import 'dart:developer';
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
  static const _adviceURI = 'https://api.adviceslip.com/advice';
  static const _imagesURI = 'https://source.unsplash.com/800x600/?';
  static const minQueryWordLenght = 3;
  final RegExp nonLetterPattern = new RegExp("[^a-zA-Z0-9]");
  final _wisdomList = <Wisdom>[];

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

  //Async Data Fetchers to get Data from external APIs ------
  Future<Wisdom> _createWisdom() async {
    final advice = await _fetchAdvice();
    final img = await _fetchImage(stringToQuery(advice.text));
    return Wisdom(advice, img);
  }

  Future<Advice> _fetchAdvice() async {
    final response = await http.get(_adviceURI);
    return Advice.fromJson(json.decode(response.body));
  }

  Future<StockImg> _fetchImage(String query) async {
    final String url = _imagesURI + query;
    return StockImg(url: url);
  }

  //Helper Functions ------
  String stringToQuery(String input) {
    final List<String> dirtyWords = input.split(nonLetterPattern);
    String query = "";
    dirtyWords.forEach((w) {
      if (w.isNotEmpty && w.length > minQueryWordLenght) {
        query += w + ",";
      }
    });
    return query;
  }
}
