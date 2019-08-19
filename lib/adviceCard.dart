import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wisgen/data/wisdoms.dart';

/**
 * Card View That displays a given Wisdom.
 * Images are Loaded from the given URL once and then cashed.
 * The Card Tracks weather it is a "favorite" or not
 */
class AdviceCard extends StatefulWidget {
  final Wisdom wisdom;

  const AdviceCard({Key key, this.wisdom}) : super(key: key);

  @override
  _AdviceCardState createState() => _AdviceCardState();
}

class _AdviceCardState extends State<AdviceCard> {
  static const double _smallPadding = 4;
  static const double _imageHeight = 300;
  static const _cardBorderRadius = 7.0;
  static const double _cardElevation = 2;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardBorderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: _cardElevation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: widget.wisdom.stockImg.url,
            fit: BoxFit.cover,
            height: _imageHeight,
            errorWidget: (context, url, error) => Container(
              child: Icon(Icons.error),
              height: _imageHeight,
            ),
          ),
          ListTile(
            title: Container(
              padding: EdgeInsets.only(top: _smallPadding, bottom: _smallPadding),
              child: Text(widget.wisdom.advice.text),
            ),
            subtitle: Container(
                padding:
                    EdgeInsets.only(top: _smallPadding, bottom: _smallPadding),
                child: Text('Advice #' + widget.wisdom.advice.id,
                    textAlign: TextAlign.left)),
            trailing: IconButton(
              icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
              color: _isFavorite ? Colors.red : Colors.grey,
              padding: EdgeInsets.all(_smallPadding),
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
