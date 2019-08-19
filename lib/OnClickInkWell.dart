import 'package:flutter/material.dart';

class OnClickInkWell extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  const OnClickInkWell({
    Key key,
    this.text,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(text),
        ),
        onTap: onClick);
  }
}