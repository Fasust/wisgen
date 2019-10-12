import 'package:flutter/material.dart';

///Text Displaying the given [Exception].
class ErrorText extends StatelessWidget {
  final Exception _exception;
  const ErrorText(this._exception);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          'We Got this Exception when trying to fetch our Wisdom:\n$_exception'),
    );
  }
}