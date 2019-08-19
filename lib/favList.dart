import 'package:flutter/material.dart';

class FavList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Wisdoms',
          style: Theme.of(context).textTheme.headline,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

}