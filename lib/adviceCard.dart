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
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
          ListTile(
            title: Container(
              padding: EdgeInsets.only(top: 4),
              child: Text(adviceText),
            ),
            subtitle: Container(
                padding: EdgeInsets.only(top: 8, bottom: 4),
                child: Text('Advice #' + id, textAlign: TextAlign.left)),
            trailing: Icon(Icons.favorite_border)
          ),
        ],
      ),
    );
  }
}
