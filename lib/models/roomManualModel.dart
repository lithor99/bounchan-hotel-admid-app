class RoomsManualModel {
  List<Result>? result;

  RoomsManualModel({this.result});

  RoomsManualModel.fromJson(Map<String, dynamic> json) {
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
  RoomType? roomType;
  List<Rooms>? rooms;

  Result({this.roomType, this.rooms});

  Result.fromJson(Map<String, dynamic> json) {
    roomType = json['roomType'] != null
        ? new RoomType.fromJson(json['roomType'])
        : null;
    if (json['rooms'] != null) {
      rooms = <Rooms>[];
      json['rooms'].forEach((v) {
        rooms!.add(new Rooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.roomType != null) {
      data['roomType'] = this.roomType!.toJson();
    }
    if (this.rooms != null) {
      data['rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoomType {
  String? id;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;

  RoomType({this.id, this.name, this.image, this.createdAt, this.updatedAt});

  RoomType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Rooms {
  String? id;
  String? roomTypeId;
  String? roomNo;
  int? price;
  dynamic lastCheckOut;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;
  RoomType? roomType;
  bool? checked = false;
  List<RoomImages>? roomImages;

  Rooms(
      {this.id,
      this.roomTypeId,
      this.roomNo,
      this.price,
      this.lastCheckOut,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.roomType,
      this.checked,
      this.roomImages});

  Rooms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomTypeId = json['roomTypeId'];
    roomNo = json['roomNo'];
    price = json['price'];
    lastCheckOut = json['lastCheckOut'];
    description = json['description'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    roomType = json['room_type'] != null
        ? new RoomType.fromJson(json['room_type'])
        : null;
    checked = json['checked'] ?? false;
    if (json['room_images'] != null) {
      roomImages = <RoomImages>[];
      json['room_images'].forEach((v) {
        roomImages!.add(new RoomImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['roomTypeId'] = this.roomTypeId;
    data['roomNo'] = this.roomNo;
    data['price'] = this.price;
    data['lastCheckOut'] = this.lastCheckOut;
    data['description'] = this.description;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['checked'] = this.checked;
    if (this.roomType != null) {
      data['room_type'] = this.roomType!.toJson();
    }
    if (this.roomImages != null) {
      data['room_images'] = this.roomImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoomImages {
  String? id;
  String? roomId;
  String? image;
  String? createdAt;
  String? updatedAt;

  RoomImages(
      {this.id, this.roomId, this.image, this.createdAt, this.updatedAt});

  RoomImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomId = json['roomId'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['roomId'] = this.roomId;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
