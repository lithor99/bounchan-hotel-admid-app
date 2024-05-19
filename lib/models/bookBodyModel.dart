class BookBodyModel {
  Item? item;

  BookBodyModel({this.item});

  BookBodyModel.fromJson(Map<String, dynamic> json) {
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    return data;
  }
}

class Item {
  String? checkInDate;
  String? checkOutDate;
  int? amount;
  List<Rooms>? rooms;

  Item({this.checkInDate, this.checkOutDate, this.amount, this.rooms});

  Item.fromJson(Map<String, dynamic> json) {
    checkInDate = json['checkInDate'];
    checkOutDate = json['checkOutDate'];
    amount = json['amount'];
    if (json['rooms'] != null) {
      rooms = <Rooms>[];
      json['rooms'].forEach((v) {
        rooms!.add(new Rooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['checkInDate'] = this.checkInDate;
    data['checkOutDate'] = this.checkOutDate;
    data['amount'] = this.amount;
    if (this.rooms != null) {
      data['rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rooms {
  String? roomId;
  String? roomNo;
  int? price;

  Rooms({this.roomId, this.roomNo, this.price});

  Rooms.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    roomNo = json['roomNo'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomId'] = this.roomId;
    data['roomNo'] = this.roomNo;
    data['price'] = this.price;
    return data;
  }
}
