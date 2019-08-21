import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:wisgen/data/wisdoms.dart';

import 'package:wisgen/data/advice.dart';
import 'package:wisgen/provider/wisdom_fav_list.dart';

import 'card_advice.dart';
import 'card_loading.dart';
import 'on_click_inkwell.dart';

/**
 * A Listview that loads Images and Text from 2 API endpoints and
 * Displays them in Cards (lazy & Asyc)
 * Images as querried by keyword int the related text
 */
class PageWisdomFeed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageWisdomFeedState();
}

class PageWisdomFeedState extends State<PageWisdomFeed> {
  //API End-Points
  static const _adviceURI = 'https://api.adviceslip.com/advice';
  static const _imagesURI = 'https://source.unsplash.com/800x600/?';
  static const _networkErrorText =
      '"No Network Connection, Tap the Screen to retry!"';

  static const int _minQueryWordLength = 3;
  static const double _margin = 16.0;
  final RegExp _nonLetterPattern = new RegExp("[^a-zA-Z0-9]");

  //Cash of Previously Loaded Wisdoms
  final List<Wisdom> _wisdoms = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView.builder(
          padding: const EdgeInsets.all(_margin),
          itemBuilder: (context, i) {
            //Decide if you need to lad new advice or if your need to load from Cash
            if (i < _wisdoms.length) {
              return _createWisdomCard(_wisdoms[i], context);
            } else {
              return FutureBuilder(
                  future: _createWisdom(),
                  builder: (context, snapshot) =>
                      _buildNewWisdomFromFetched(context, snapshot));
            }
          }),
    );
  }

  //UI-Elements ------
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Wisdom Feed',
        style: Theme.of(context).textTheme.headline,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      actions: <Widget>[
        IconButton(
          iconSize: 40,
          icon: Icon(
            Icons.list,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed("/favorites");
          },
        )
      ],
    );
  }

  Widget _buildNewWisdomFromFetched(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    Wisdom wisdom = snapshot.data;
    if (snapshot.connectionState == ConnectionState.done) {
      if (!snapshot.hasError) {
        _wisdoms.add(wisdom);
        return _createWisdomCard(wisdom, context);
      } else {
        return new OnClickInkWell(
          text: _networkErrorText,
          onClick: () {
            setState(() {});
          },
        );
      }
    } else {
      return CardLoading();
    }
  }

  CardAdvice _createWisdomCard(Wisdom wisdom, BuildContext context) {
    return CardAdvice(
        wisdom: wisdom,
        onLike: () => _onLike(Provider.of<WisdomFavList>(context), wisdom));
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
      if (w.isNotEmpty && w.length > _minQueryWordLength) {
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

  //CallBack ------
  void _onLike(WisdomFavList favList, Wisdom wisdom) {
    bool isFav = favList.contains(wisdom);
    if (isFav) {
      favList.remove(wisdom);
    } else {
      favList.add(wisdom);
    }
  }
}
