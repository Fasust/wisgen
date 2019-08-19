import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wisgen/data/wisdoms.dart';

import 'adviceCard.dart';
import 'data/advice.dart';
import 'loadingCard.dart';

/**
 * A Listview that loads Images and Text from 2 API endpoints and
 * Displays them in Cards (lazy & Asyc)
 * Images as querried by keyword int the related text
 */
class CardFeed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CardFeedState();
}

class CardFeedState extends State<CardFeed> {
  //API End-Points
  static const _adviceURI = 'https://api.adviceslip.com/advice';
  static const _imagesURI = 'https://source.unsplash.com/800x600/?';

  static const minQueryWordLenght = 3;
  final RegExp _nonLetterPattern = new RegExp("[^a-zA-Z0-9]");

  //cashing of Wisdoms
  final favoriteList = <Wisdom>[];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          return FutureBuilder(
              future: _createWisdom(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  if(!snapshot.hasError){
                    return AdviceCard(wisdom: snapshot.data,onLike:(){
                      favoriteList.add(snapshot.data);
                    });
                  }else{
                    	return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text("No Network Connection, Tap the Screen to retry!"),
                      ),
                      onTap: () => setState(() {}));
                  }
                }else{
                  return LoadingCard();
                }
              });
        });
  }

  //Async Data Fetchers to get Data from external APIs ------
  Future<Wisdom> _createWisdom() async {
    final advice = await _fetchAdvice();
    final img = await _fetchImage(advice.text);
    return Wisdom(advice, img);
  }

  Future<Advice> _fetchAdvice() async {
    final response = await http.get(_adviceURI);
    return Advice.fromJson(json.decode(response.body));
  }

  Future<String> _fetchImage(String adviceText) async {
    return _imagesURI + _stringToQuery(adviceText);
  }

  //Helper Functions ------
  String _stringToQuery(String input) {
    final List<String> dirtyWords = input.split(_nonLetterPattern);
    String query = "";
    dirtyWords.forEach((w) {
      if (w.isNotEmpty && w.length > minQueryWordLenght) {
        query += w + ",";
      }
    });
    return query;
  }

  void _showDialog(String title, String body) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(body),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
