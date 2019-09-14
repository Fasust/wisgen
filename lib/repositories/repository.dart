import 'package:flutter/cupertino.dart';

///Interface for a Generic List Provider that fetches a given amount of T
abstract class Repository<T>{
  Future<List<T>> fetch(int amount, BuildContext context);
}