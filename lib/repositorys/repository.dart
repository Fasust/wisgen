import 'dart:math';

import 'package:flutter/cupertino.dart';
abstract class Repository<T>{
  Future<List<T>> fetch(int amount, BuildContext context);
}