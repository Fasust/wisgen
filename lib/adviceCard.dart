import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wisgen/data/wisdoms.dart';

class AdviceCard extends StatefulWidget {
  final Wisdom wisdom;

  const AdviceCard({Key key, this.wisdom}) : super(key: key);

  @override
  _AdviceCardState createState() => _AdviceCardState();
}

class _AdviceCardState extends State<AdviceCard> {
  static const double smallPadding = 4;
  static const double imageHeight = 300;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: widget.wisdom.stockImg.url,
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
              padding: EdgeInsets.only(top: smallPadding, bottom: smallPadding),
              child: Text(widget.wisdom.advice.text),
            ),
            subtitle: Container(
                padding:
                    EdgeInsets.only(top: smallPadding, bottom: smallPadding),
                child: Text('Advice #' + widget.wisdom.advice.id,
                    textAlign: TextAlign.left)),
            trailing: IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              color: isFavorite? Colors.red : Colors.grey,
              onPressed: (){
                setState(() {
                 isFavorite = !isFavorite; 
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
