import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        "Nothing Here 🤷‍♂️",
        style: Theme.of(context).textTheme.subtitle,
      )),
      //filling blank space with White background to register as dargable widget
      constraints: BoxConstraints.expand(),
      color: Colors.white,
    );
  }
}