import 'package:flutter/material.dart';
import 'package:wisgen/ui/widgets/loading_spinner.dart';


///A Loading animation with (around) the same height as a 
///WisdomCard that can be loaded into a list.
///WisdomCards do not have a fixed height, so we have to approximate
class LoadingCard extends StatelessWidget {
  static const double _height = 350;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
            height: _height,
            alignment: Alignment(0.0, 0.0),
            child: LoadingSpinner()
        ),
    );
  }
}
