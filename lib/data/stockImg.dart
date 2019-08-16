class StockImg {
  final String url;
  final int width;
  final int height;
  final String author;

  StockImg(this.url, this.width, this.height, this.author);
  factory StockImg.fromJson(Map<String, dynamic> json) {
    return StockImg(json['download_url'], json['width'],json['height'],json['author']);
  }
}