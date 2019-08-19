import 'dart:typed_data';

/**
 * Img consisting of url and a byte stream
 * (Byte stream is not used atm)
 */
class StockImg {
  final String url;
  final Uint8List imgBytes;

  StockImg({this.url, this.imgBytes});
}