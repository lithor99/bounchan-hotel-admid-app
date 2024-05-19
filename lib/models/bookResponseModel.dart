class BookResponseModel {
  Result? result;

  BookResponseModel({this.result});

  BookResponseModel.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? id;
  int? status;
  String? memberId;
  int? amount;
  String? checkInDate;
  String? checkOutDate;
  String? updatedAt;
  String? createdAt;

  Result(
      {this.id,
      this.status,
      this.memberId,
      this.amount,
      this.checkInDate,
      this.checkOutDate,
      this.updatedAt,
      this.createdAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    memberId = json['memberId'];
    amount = json['amount'];
    checkInDate = json['checkInDate'];
    checkOutDate = json['checkOutDate'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['memberId'] = this.memberId;
    data['amount'] = this.amount;
    data['checkInDate'] = this.checkInDate;
    data['checkOutDate'] = this.checkOutDate;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
