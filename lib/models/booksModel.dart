class BooksModel {
  Result? result;

  BooksModel({this.result});

  BooksModel.fromJson(Map<String, dynamic> json) {
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
  int? count;
  List<Rows>? rows;

  Result({this.count, this.rows});

  Result.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(new Rows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rows {
  String? id;
  String? memberId;
  int? amount;
  String? checkInDate;
  String? checkOutDate;
  dynamic checkInBy;
  dynamic checkOutBy;
  int? status;
  String? createdAt;
  String? updatedAt;
  Member? member;

  Rows(
      {this.id,
      this.memberId,
      this.amount,
      this.checkInDate,
      this.checkOutDate,
      this.checkInBy,
      this.checkOutBy,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.member});

  Rows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['memberId'];
    amount = json['amount'];
    checkInDate = json['checkInDate'];
    checkOutDate = json['checkOutDate'];
    checkInBy = json['checkInBy'];
    checkOutBy = json['checkOutBy'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    member =
        json['member'] != null ? new Member.fromJson(json['member']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['memberId'] = this.memberId;
    data['amount'] = this.amount;
    data['checkInDate'] = this.checkInDate;
    data['checkOutDate'] = this.checkOutDate;
    data['checkInBy'] = this.checkInBy;
    data['checkOutBy'] = this.checkOutBy;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.member != null) {
      data['member'] = this.member!.toJson();
    }
    return data;
  }
}

class Member {
  String? id;
  String? name;
  String? lastName;
  String? gender;
  String? phoneNumber;
  String? email;
  String? image;
  String? password;
  dynamic deviceToken;
  int? blocked;
  String? createdAt;
  String? updatedAt;

  Member(
      {this.id,
      this.name,
      this.lastName,
      this.gender,
      this.phoneNumber,
      this.email,
      this.image,
      this.password,
      this.deviceToken,
      this.blocked,
      this.createdAt,
      this.updatedAt});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    image = json['image'];
    password = json['password'];
    deviceToken = json['deviceToken'];
    blocked = json['blocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['image'] = this.image;
    data['password'] = this.password;
    data['deviceToken'] = this.deviceToken;
    data['blocked'] = this.blocked;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
