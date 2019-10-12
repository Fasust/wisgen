import 'package:flutter/cupertino.dart';

///Interface for a Generic Provider that fetches a given amount of T
abstract class Repository<T>{
  Future<T> fetch(int amount, BuildContext context);
}