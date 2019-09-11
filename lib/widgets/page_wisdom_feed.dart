import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:wisgen/data/wisdoms.dart';

import 'package:wisgen/data/advice.dart';
import 'package:wisgen/tools/preference_provider_link.dart';
import 'package:wisgen/widgets/page_favorites.dart';
import 'package:wisgen/provider/wisdom_fav_list.dart';

import 'card_advice.dart';
import 'card_loading.dart';
import 'on_click_inkwell.dart';

/**
 * A Listview that loads Images and Text from 2 API endpoints and
 * Displays them in Cards (lazy & Asyc)
 * Images as querried by keyword int the related text
 * The Favorite Wisdoms are saved on the Phone using a PreferenceProviderLink
 */
class PageWisdomFeed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageWisdomFeedState();
}

class PageWisdomFeedState extends State<PageWisdomFeed> {
  static const _adviceURI = 'https://api.adviceslip.com/advice';
  static const _imagesURI = 'https://source.unsplash.com/800x600/?';
  static const _localAdvicePath = './assets/advice.txt';
  static const _networkErrorText =
      'No Network Connection, Tap the Screen to retry!';
  final RegExp _nonLetterPattern = new RegExp("[^a-zA-Z0-9]");
  final random = new Random();

  //UI
  static const int _minQueryWordLength = 3;
  static const double _margin = 16.0;

  //Cash of Previously Loaded Wisdoms
  final List<Wisdom> _wisdoms = new List();

  //Cash of local Wisdoms
  List<Advice> _localAdvice;

  //Storage on Device
  static final PreferenceProviderLink _prefLink =
      new PreferenceProviderLink<WisdomFavList>(
          'wisdom_favs', new Wisdom(null, null));

  @override
  void initState() {
    _prefLink.readPrefs(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          _swipeNavigation(context, details);
        },
        child: ListView.builder(
            padding: const EdgeInsets.all(_margin),
            itemBuilder: (context, i) {
              //Decide if you need to lad new advice or if your need to load from Cash
              if (i < _wisdoms.length) {
                return _createWisdomCard(_wisdoms[i], context);
              } else {
                return FutureBuilder(
                    future: _createWisdom(context),
                    builder: (context, snapshot) =>
                        _buildNewWisdomFromFetched(context, snapshot));
              }
            }),
      ),
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
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => PageFavoriteList()));
          },
        )
      ],
    );
  }

  Widget _buildNewWisdomFromFetched(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    Wisdom wisdom = snapshot.data;
    if (snapshot.connectionState == ConnectionState.done) {
      if (!snapshot.hasError) {
        if (!_wisdoms.contains(wisdom)) {
          _wisdoms.add(wisdom);
        } //The If block keeps the Future fro re-adding the exact same entry again when re-fiering after a rebuild
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
    return CardAdvice(wisdom: wisdom, onLike: () => onLike(context, wisdom));
  }

  //Async Data Fetchers to get Data from external APIs ------
  Future<Wisdom> _createWisdom(BuildContext context) async {
    final advice = await _fetchLocalAdvice(context);
    final img = await _fetchImage(advice.text);
    return Wisdom(advice, img);
  }

  Future<Advice> _fetchAdvice() async {
    final response = await http.get(_adviceURI);
    return Advice.fromJson(json.decode(response.body));
  }

  Future<Advice> _fetchLocalAdvice(BuildContext context) async {
    if (_localAdvice == null) {
      _localAdvice = await _bufferLocalAdvice(context);
    }
    return _localAdvice[random.nextInt(_localAdvice.length)];
  }

  Future<String> _fetchImage(String adviceText) async {
    return _imagesURI + _stringToQuery(adviceText);
  }

  Future<List<Advice>> _bufferLocalAdvice(BuildContext context) async {
    String localAdvice =
        await DefaultAssetBundle.of(context).loadString(_localAdvicePath);
    List<String> adviceStrings = localAdvice.split('\n');
    List<Advice> wisdoms = new List();

    String currentType;
    int relativeIndex;

    for (int i = 0; i < adviceStrings.length; i++) {
      if (adviceStrings[i].startsWith('#')) {
        //new type of advice
        adviceStrings[i] = adviceStrings[i].substring(2);
        currentType = adviceStrings[i];
        relativeIndex = 1;
        continue; //do not add type header
      }
      wisdoms.add(new Advice(
          id: '$relativeIndex', text: adviceStrings[i], type: currentType));
      relativeIndex++;
    }
    return wisdoms;
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

  void _swipeNavigation(BuildContext context, DragEndDetails details) {
    if (details.primaryVelocity.compareTo(0) == -1) //right to left
      Navigator.push(context,
          CupertinoPageRoute(builder: (context) => PageFavoriteList()));
  }

  //CallBack ------
  static void onLike(BuildContext context, Wisdom wisdom) {
    WisdomFavList favList = Provider.of<WisdomFavList>(context);
    bool isFav = favList.contains(wisdom);
    if (isFav) {
      favList.remove(wisdom);
    } else {
      favList.add(wisdom);
    }

    _prefLink.writePrefs(context);
  }
}