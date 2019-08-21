import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisgen/data/wisdoms.dart';
import 'package:wisgen/provider/wisdom_fav_list.dart';

/**
 * Card View That displays a given Wisdom.
 * Images are Loaded from the given URL once and then cashed.
 * Information about Fav-Status are loaded with a Consumer from the CardFeed
 */
class CardAdvice extends StatelessWidget {
  static const double _smallPadding = 4;
  static const double _imageHeight = 300;
  static const double _cardElevation = 2;
  static const double _cardBorderRadius = 7.0;

  final Wisdom wisdom;
  final VoidCallback onLike;

  CardAdvice({Key key, this.wisdom, this.onLike}) : super(key: key);

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
          new _Image(wisdom: wisdom, imageHeight: _imageHeight),
          new _Content(
            smallPadding: _smallPadding,
            wisdom: wisdom,
            onLike: onLike,
          )
        ],
      ),
    );
  }
}

//File-wide Widgets -----------------
class _Content extends StatelessWidget {
  const _Content({
    Key key,
    @required double smallPadding,
    @required this.wisdom,
    @required this.onLike,
  })  : _smallPadding = smallPadding,
        super(key: key);

  final double _smallPadding;
  final Wisdom wisdom;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        padding: EdgeInsets.only(top: _smallPadding, bottom: _smallPadding),
        child: Text(wisdom.advice.text),
      ),
      subtitle: Container(
          padding: EdgeInsets.only(top: _smallPadding, bottom: _smallPadding),
          child:
              Text('Advice #' + wisdom.advice.id, textAlign: TextAlign.left)),
      trailing: Consumer<WisdomFavList>(
        builder: (context, favorites, _) => IconButton(
          icon: Icon(favorites.contains(wisdom)
              ? Icons.favorite
              : Icons.favorite_border),
          color: favorites.contains(wisdom) ? Colors.red : Colors.grey,
          padding: EdgeInsets.all(_smallPadding),
          onPressed: onLike,
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    Key key,
    @required this.wisdom,
    @required double imageHeight,
  })  : _imageHeight = imageHeight,
        super(key: key);

  final Wisdom wisdom;
  final double _imageHeight;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: wisdom.stockImURL,
      fit: BoxFit.cover,
      height: _imageHeight,
      errorWidget: (context, url, error) => Container(
        child: Icon(Icons.error),
        height: _imageHeight,
      ),
    );
  }
}
