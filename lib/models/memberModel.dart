class MemberModel {
  Result? result;

  MemberModel({this.result});

  MemberModel.fromJson(Map<String, dynamic> json) {
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

  Result(
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

  Result.fromJson(Map<String, dynamic> json) {
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
