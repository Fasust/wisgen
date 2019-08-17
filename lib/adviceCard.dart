import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wisgen/data/wisdoms.dart';

class AdviceCard extends StatelessWidget {
  static const double smallPadding = 4;
  static const double imageHeight = 300;
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
            height: imageHeight,
            errorWidget: (context, url, error) => Container(
              child: Icon(Icons.error),
              height: imageHeight,
            ),
          ),
          // Image.memory(wisdom.stockImg.imgBytes,
          //     height: 300, fit: BoxFit.cover),
          ListTile(
              title: Container(
                padding:
                    EdgeInsets.only(top: smallPadding, bottom: smallPadding),
                child: Text(wisdom.advice.text),
              ),
              subtitle: Container(
                  padding:
                      EdgeInsets.only(top: smallPadding, bottom: smallPadding),
                  child: Text('Advice #' + wisdom.advice.id,
                      textAlign: TextAlign.left)),
              trailing: Icon(Icons.favorite_border)),
        ],
      ),
    );
  }
}
