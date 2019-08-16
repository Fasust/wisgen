import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'data/stockImg.dart';

class AdviceCard extends StatelessWidget {
  final String id;
  final String adviceText;
  final StockImg img;

  AdviceCard(
      {Key key,
      @required this.id,
      @required this.adviceText,
      @required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: img.url,
            fit: BoxFit.cover,
            height: 300,
            placeholder: (context, url) => Container(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
          ListTile(
            title: Text(adviceText),
            subtitle: Text('Advice #'+id,textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}
