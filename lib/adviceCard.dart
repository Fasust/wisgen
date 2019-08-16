import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wisgen/data/wisdoms.dart';

import 'data/stockImg.dart';

class AdviceCard extends StatelessWidget {
  final Wisdom wisdom;

  const AdviceCard({Key key, this.wisdom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: wisdom.stockImg.url,
            fit: BoxFit.cover,
            height: 300,
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
          /**Image.memory(wisdom.stockImg.imgBytes,
              height: 300, fit: BoxFit.cover), **/
          ListTile(
              title: Container(
                padding: EdgeInsets.only(top: 4),
                child: Text(wisdom.advice.text),
              ),
              subtitle: Container(
                  padding: EdgeInsets.only(top: 8, bottom: 4),
                  child: Text('Advice #' + wisdom.advice.id,
                      textAlign: TextAlign.left)),
              trailing: Icon(Icons.favorite_border)),
        ],
      ),
    );
  }
}
