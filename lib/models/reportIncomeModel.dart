class ReportIncomeModel {
  List<Result>? result;

  ReportIncomeModel({this.result});

  ReportIncomeModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? date;
  int? count;
  String? amount;

  Result({this.date, this.count, this.amount});

  Result.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    count = json['count'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['count'] = this.count;
    data['amount'] = this.amount;
    return data;
  }
}
