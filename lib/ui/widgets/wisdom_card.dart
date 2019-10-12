import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:wisgen/blocs/favorite_bloc.dart';
import 'package:wisgen/blocs/favorite_event.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/ui/widgets/loading_spinner.dart';

///Card View That displays a given Wisdom.
///Images are Loaded from the given URL once and then cashed.
///The Favorite Button Subscribes to the Global FavoriteBLoC to change it's appearance.
///The Button also Publishes Events to the FavoriteBLoC when it is pressed.
class WisdomCard extends StatelessWidget {
  static const double _cardElevation = 2;
  static const double _cardBorderRadius = 7;

  final Wisdom _wisdom;

  WisdomCard(this._wisdom);

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
          _Image(_wisdom.imgURL),
          _Content(_wisdom),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  static const double _imageHeight = 300;
  const _Image(this._url);

  final String _url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: _url,
      fit: BoxFit.cover,
      height: _imageHeight,
      errorWidget: (context, url, error) => Container(
        child: Icon(Icons.error),
        height: _imageHeight,
      ),
      placeholder: (context, url) => Container(
          alignment: Alignment(0.0, 0.0),
          height: _imageHeight,
          child: LoadingSpinner(),
      )
    );
  }
}

class _Content extends StatelessWidget {
  static const double _smallPadding = 4;
  static const double _largePadding = 8;
  final Wisdom _wisdom;

  const _Content(this._wisdom);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: _largePadding, bottom: _largePadding),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 5,
              child: ListTile(
                title: Text(_wisdom.text),
                subtitle: Container(
                    padding: EdgeInsets.only(top: _smallPadding),
                    child: Text(_wisdom.type + ' #' + '${_wisdom.id}',
                        textAlign: TextAlign.left)),
              )),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.share),
              color: Colors.grey,
              onPressed: () {
                Share.share(_wisdom.shareAsString());
              },
            ),
          ),
          _LikeButton(wisdom: _wisdom, smallPadding: _smallPadding)
        ],
      ),
    );
  }

}

class _LikeButton extends StatelessWidget {
  const _LikeButton({
    Key key,
    @required Wisdom wisdom,
    @required double smallPadding,
  }) : _wisdom = wisdom, _smallPadding = smallPadding, super(key: key);

  final Wisdom _wisdom;
  final double _smallPadding;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      //This is where we Subscribe to the FavoriteBLoC
      child: BlocBuilder<FavoriteBloc, List<Wisdom>>(
        builder: (context, favorites) => IconButton(
          icon: Icon(favorites.contains(_wisdom)
              ? Icons.favorite
              : Icons.favorite_border),
          color: favorites.contains(_wisdom) ? Colors.red : Colors.grey,
          onPressed: () {_onLike(context,favorites);},
          padding: EdgeInsets.only(right: _smallPadding),
        ),
      ),
    );
  }

  ///Figures out if a Wisdom is already liked or not.
  ///Then send corresponding Event.
  void _onLike(BuildContext context, List<Wisdom> favorites) {
    final FavoriteBloc favoriteBloc = BlocProvider.of<FavoriteBloc>(context);

    if (favorites.contains(_wisdom)) {
      favoriteBloc.dispatch(FavoriteEventRemove(_wisdom));
    } else {
      favoriteBloc.dispatch(FavoriteEventAdd(_wisdom));
    }
  }
}

