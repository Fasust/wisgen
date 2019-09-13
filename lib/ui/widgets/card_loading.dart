import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wisgen/ui/ui_helper.dart';

/**
 * A Loading animation with Padding that can be loaded into a list
 */
class CardLoading extends StatelessWidget {
  static const double _height = 350;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
            height: _height,
            alignment: Alignment(0.0, 0.0),
            child: new SpinKitCircle(
              color: Theme.of(context).accentColor,
              size: UIHelper.loadingAnimSize,
            )));
  }
}
