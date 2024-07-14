class ReportChartModel {
  List<Result>? result;

  ReportChartModel({this.result});

  ReportChartModel.fromJson(Map<String, dynamic> json) {
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
  String? month;
  int? member;
  Book? book;
  dynamic income;

  Result({this.month, this.member, this.book, this.income});

  Result.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    member = json['member'];
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
    income = json['income'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['member'] = this.member;
    if (this.book != null) {
      data['book'] = this.book!.toJson();
    }
    data['income'] = this.income;
    return data;
  }
}

class Book {
  int? success;
  int? cancel;

  Book({this.success, this.cancel});

  Book.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    cancel = json['cancel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['cancel'] = this.cancel;
    return data;
  }
}
