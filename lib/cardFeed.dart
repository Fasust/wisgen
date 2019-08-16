import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'adviceCard.dart';
import 'data/advice.dart';
import 'data/stockImg.dart';
import 'loadingCard.dart';

class CardFeed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CardFeedState();
}

class CardFeedState extends State<CardFeed> {
  static const _stockImgListLenght = 100;
  final _adviceURI = 'https://api.adviceslip.com/advice';
  final _imagesURI = 'https://picsum.photos/v2/list?page=1&limit=' +
      _stockImgListLenght.toString();

  final _adviveList = <Advice>[];
  final _stockImgList = <StockImg>[];
  int _stockImgIndex = 0;

  @override
  void initState() {
    _fetchImageList().then((list) {
      setState(() {
        _stockImgList.addAll(list);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          log("Index: " + i.toString());
          return FutureBuilder(
              future: _fetchAdvice(),
              builder: (context, advice) {
                if (advice.connectionState == ConnectionState.done) {
                  _adviveList.add(advice.data);
                  return _buildCard(advice.data,
                      _stockImgList[_stockImgIndex++ % _stockImgListLenght]);
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

  Future<List<StockImg>> _fetchImageList() async {
    final response = await http.get(_imagesURI);
    List<dynamic> parsedJson = json.decode(response.body);
    List<StockImg> stockImgList = new List();

    parsedJson.forEach((e) {
      stockImgList.add(StockImg.fromJson(e));
    });
    return stockImgList;
  }

  AdviceCard _buildCard(Advice a, StockImg img) {
    return AdviceCard(
      id: a.id,
      adviceText: a.text,
      img: img,
    );
  }
}
