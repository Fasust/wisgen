import 'package:flutter/material.dart';

class AdviceCard extends StatelessWidget {
  final String id;
  final String adviceText;
  final String imgURL;

  AdviceCard(
      {Key key,
      @required this.id,
      @required this.adviceText,
      this.imgURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.network('https://picsum.photos/200/200',
            fit: BoxFit.fill,),
          ListTile(
            title: Text(adviceText),
            subtitle: Text('Advice #'+id,textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}
