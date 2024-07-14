class BookModel {
  Result? result;

  BookModel({this.result});

  BookModel.fromJson(Map<String, dynamic> json) {
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
  String? memberId;
  String? billNo;
  int? amount;
  String? checkInDate;
  String? checkOutDate;
  dynamic checkInBy;
  dynamic checkOutBy;
  int? status;
  String? createdAt;
  String? updatedAt;
  Member? member;
  List<BookDetails>? bookDetails;

  Result(
      {this.id,
      this.memberId,
      this.billNo,
      this.amount,
      this.checkInDate,
      this.checkOutDate,
      this.checkInBy,
      this.checkOutBy,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.member,
      this.bookDetails});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['memberId'];
    billNo = json['billNo'];
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
    if (json['book_details'] != null) {
      bookDetails = <BookDetails>[];
      json['book_details'].forEach((v) {
        bookDetails!.add(new BookDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['memberId'] = this.memberId;
    data['billNo'] = this.billNo;
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
    if (this.bookDetails != null) {
      data['book_details'] = this.bookDetails!.map((v) => v.toJson()).toList();
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

class BookDetails {
  String? id;
  String? bookId;
  String? roomId;
  int? price;
  String? createdAt;
  String? updatedAt;
  String? roomNo;

  BookDetails(
      {this.id,
      this.bookId,
      this.roomId,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.roomNo});

  BookDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookId = json['bookId'];
    roomId = json['roomId'];
    price = json['price'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    roomNo = json['roomNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bookId'] = this.bookId;
    data['roomId'] = this.roomId;
    data['price'] = this.price;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['roomNo'] = this.roomNo;
    return data;
  }
}
