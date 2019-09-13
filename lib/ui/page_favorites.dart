import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisgen/ui/ui_helper.dart';

class PageFavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            _swipeNavigation(context, details);
          },
          child: new Text("data")),
    );
  }

  //UI-Elements -----
  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Favorite Wisdoms',
        style: Theme.of(context).textTheme.headline,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  ListView _listView(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(UIHelper.listPadding),
      itemBuilder: (context, i) {},
    );
  }
}

//Helper Functions
void _swipeNavigation(BuildContext context, DragEndDetails details) {
  if (details.primaryVelocity.compareTo(0) == 1) //left to right
    Navigator.of(context).pop();
}
