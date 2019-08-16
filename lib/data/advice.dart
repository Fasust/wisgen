class Advice {
  final String id;
  final String text;

  Advice(this.id, this.text);
  factory Advice.fromJson(Map<String, dynamic> json) {
    return Advice(json['slip']['slip_id'], json['slip']['advice']);
  }
}
