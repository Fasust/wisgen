import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:wisgen/data/wisdoms.dart';

import 'data/wisdomFavlist.dart';

/**
 * Card View That displays a given Wisdom.
 * Images are Loaded from the given URL once and then cashed.
 * The Card Tracks weather it is a "favorite" or not
 */
class AdviceCard extends StatelessWidget {
  final Wisdom wisdom;
  static const double _smallPadding = 4;
  static const double _imageHeight = 300;
  static const _cardBorderRadius = 7.0;
  static const double _cardElevation = 2;
  final VoidCallback onLike;

  AdviceCard({Key key, this.wisdom, this.onLike}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WisdomFavList>(
      builder: (context, favorites, _) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_cardBorderRadius),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: _cardElevation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: wisdom.stockImURL,
              fit: BoxFit.cover,
              height: _imageHeight,
              errorWidget: (context, url, error) => Container(
                child: Icon(Icons.error),
                height: _imageHeight,
              ),
            ),
            ListTile(
              title: Container(
                padding:
                    EdgeInsets.only(top: _smallPadding, bottom: _smallPadding),
                child: Text(wisdom.advice.text),
              ),
              subtitle: Container(
                  padding: EdgeInsets.only(
                      top: _smallPadding, bottom: _smallPadding),
                  child: Text('Advice #' + wisdom.advice.id,
                      textAlign: TextAlign.left)),
              trailing: IconButton(
                icon: Icon(favorites.contains(wisdom) ? Icons.favorite : Icons.favorite_border),
                color: favorites.contains(wisdom) ? Colors.red : Colors.grey,
                padding: EdgeInsets.all(_smallPadding),
                onPressed: onLike,
              ),
            )
          ],
        ),
      ),
    );
  }
}
