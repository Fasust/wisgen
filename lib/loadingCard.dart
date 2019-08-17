import 'package:flutter/material.dart';

class LoadingCard extends StatelessWidget {
  static const double edges = 170;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.all(edges),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
