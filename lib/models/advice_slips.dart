import 'package:wisgen/models/wisdom.dart';

///Generated Class to Handle JSON Input from AdviceSlip API.
///I used this tool: https://javiercbk.github.io/json_to_dart/.
class AdviceSlips {
  String totalResults;
  String query;
  List<Slips> slips;

  AdviceSlips({this.totalResults, this.query, this.slips});

  AdviceSlips.fromJson(Map<String, dynamic> json) {
    totalResults = json['total_results'];
    query = json['query'];
    if (json['slips'] != null) {
      slips = List<Slips>();
      json['slips'].forEach((v) {
        slips.add(Slips.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total_results'] = this.totalResults;
    data['query'] = this.query;
    if (this.slips != null) {
      data['slips'] = this.slips.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

///Generated Class to Handle JSON Input from AdviceSlip API.
///I used this tool: https://javiercbk.github.io/json_to_dart/.
///A Slip can be converted directly into a Wisdom.
class Slips {
  String advice;
  String slipId;

  Slips({this.advice, this.slipId});

  Slips.fromJson(Map<String, dynamic> json) {
    advice = json['advice'];
    slipId = json['slip_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['advice'] = this.advice;
    data['slip_id'] = this.slipId;
    return data;
  }

  Wisdom toWisdom() {
    return Wisdom(
      id: int.parse(slipId),
      text: advice,
      type: "Advice Slip",
    );
  }
}
