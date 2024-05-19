class ReportBookModel {
  Result? result;

  ReportBookModel({this.result});

  ReportBookModel.fromJson(Map<String, dynamic> json) {
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
  List<BookDetails>? bookDetails;

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
      this.bookDetails});

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
    data['amount'] = this.amount;
    data['checkInDate'] = this.checkInDate;
    data['checkOutDate'] = this.checkOutDate;
    data['checkInBy'] = this.checkInBy;
    data['checkOutBy'] = this.checkOutBy;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.bookDetails != null) {
      data['book_details'] = this.bookDetails!.map((v) => v.toJson()).toList();
    }
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

  BookDetails(
      {this.id,
      this.bookId,
      this.roomId,
      this.price,
      this.createdAt,
      this.updatedAt});

  BookDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookId = json['bookId'];
    roomId = json['roomId'];
    price = json['price'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bookId'] = this.bookId;
    data['roomId'] = this.roomId;
    data['price'] = this.price;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
