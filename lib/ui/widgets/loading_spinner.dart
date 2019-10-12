import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wisgen/ui/ui_helper.dart';

///Loading Animation in [Theme] accentColor.
class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return Center(
            child: SpinKitCircle(
          color: Theme.of(context).accentColor,
          size: UiHelper.loadingAnimSize,
    ));
  }
}