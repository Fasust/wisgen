import 'package:wisgen/data/advice.dart';
import 'package:wisgen/data/stockImg.dart';

/**
 * Data Structure that combines an shockImg and and an Advice to form a "Wisdom"
 */
class Wisdom{
  final Advice advice;
  final StockImg stockImg;

  Wisdom(this.advice, this.stockImg);
}