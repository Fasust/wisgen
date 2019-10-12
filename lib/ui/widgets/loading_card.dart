import 'package:flutter/material.dart';
import 'package:wisgen/ui/widgets/loading_spinner.dart';


///A Loading animation on [Card]
///
///It is (around) the same height as a [WisdomCard], so a list of
///[WisdomCard]s and [LoadingCard]s wont jump around 
///when one is swapped for the other.
///[WisdomCard]s do not have a fixed height, so we have to approximate
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
