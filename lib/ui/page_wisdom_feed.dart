import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wisgen/ui/page_favorites.dart';
import 'package:wisgen/ui/ui_helper.dart';

class PageWisdomFeed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageWisdomFeedState();
}

class PageWisdomFeedState extends State<PageWisdomFeed> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          _swipeNavigation(context, details);
        },
        child: ListView.builder(
            padding: const EdgeInsets.all(UIHelper.listPadding),
            itemBuilder: (context, i) {}),
      ),
    );
  }

  //UI-Elements ------
  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Wisdom Feed',
        style: Theme.of(context).textTheme.headline,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      actions: <Widget>[
        IconButton(
          iconSize: UIHelper.iconSize,
          icon: Icon(
            Icons.list,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => PageFavoriteList()));
          },
        )
      ],
    );
  }

  void _swipeNavigation(BuildContext context, DragEndDetails details) {
    if (details.primaryVelocity.compareTo(0) == -1) //right to left
      Navigator.push(context,
          CupertinoPageRoute(builder: (context) => PageFavoriteList()));
  }
}
