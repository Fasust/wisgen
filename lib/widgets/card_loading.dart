import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/**
 * A Loading animation with Padding that can be loaded into a list
 */
class CardLoading extends StatelessWidget {
  static const double _edges = 170;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
            padding: EdgeInsets.all(_edges),
            child: new SpinKitCircle(
              color: Theme.of(context).accentColor,
              size: 75.0,
            )));
  }
}
