import 'package:flutter/material.dart';
import 'cardFeed.dart';

void main() => runApp(MyApp());

/**
 * Material App Frame
 * Loads CardFeed
 */
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(
          'Wisdom Feed',
          style: TextStyle(color: Colors.white,fontSize: 23),
        ),
        backgroundColor: Color.fromRGBO(56, 43, 115, 1),
      ),
      body: CardFeed(),
    ));
  }
}
