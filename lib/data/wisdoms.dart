import 'package:wisgen/data/advice.dart';

/**
 * Data Structure that combines an shockImg and and an Advice to form a "Wisdom"
 */
class Wisdom{
  final Advice advice;
  final String stockImURL;

  Wisdom(this.advice, this.stockImURL);
}