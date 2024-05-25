import 'dart:io';

import 'package:bounchan_hotel_admin_app/constants/string.dart';
import 'package:bounchan_hotel_admin_app/models/loginModel.dart';
import 'package:bounchan_hotel_admin_app/models/staffModel.dart';
import 'package:bounchan_hotel_admin_app/models/staffsModel.dart';
import 'package:bounchan_hotel_admin_app/models/uploadModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/storageManager.dart';

//create staff
Future<StaffModel?> createStaffService({
  required String name,
  required String lastName,
  required String gender,
  required String phoneNumber,
  required String email,
  required String password,
  String? image,
  required String birthDate,
  required int role,
  String? address,
}) async {
  String url = "${BASE_URL}/staff";
  Map body = {
    "name": name,
    "lastName": lastName,
    "gender": gender,
    "phoneNumber": phoneNumber,
    "email": email,
    "password": password,
    "image": image,
    "birthDate": birthDate,
    "role": role,
    "address": address,
  };
  try {
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return StaffModel.fromJson(jsonDecode(response.body));
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    rethrow;
  }
}

//login
Future<LoginModel?> loginService(
    {required String email, required String password}) async {
  String url = "${BASE_URL}/staff/login";
  try {
    Map body = {"email": email, "password": password};
    print(body);
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      LoginModel loginModel = LoginModel.fromJson(jsonDecode(response.body));

      //delete data from local storage
      StorageManager.deleteData("id");
      StorageManager.deleteData("name");
      StorageManager.deleteData("image");
      StorageManager.deleteData("email");
      StorageManager.deleteData("phoneNumber");
      StorageManager.deleteData("token");
      StorageManager.deleteData("password");
      StorageManager.deleteData("role");
      //save data to local storage
      StorageManager.saveData("id", loginModel.result!.data!.id);
      StorageManager.saveData(
          "name",
          loginModel.result!.data!.name! +
              " " +
              loginModel.result!.data!.lastName!);
      StorageManager.saveData("image", loginModel.result!.data!.image);
      StorageManager.saveData("email", loginModel.result!.data!.email);
      StorageManager.saveData(
          "phoneNumber", loginModel.result!.data!.phoneNumber);
      StorageManager.saveData("token", loginModel.result!.token);
      StorageManager.saveData("role", loginModel.result!.data!.role ?? 2);
      return loginModel;
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    rethrow;
  }
}

//upload image
Future<UploadModel?> uploadFileService({required File file}) async {
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$BASE_URL/upload"),
    );
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    // final decodedMap = json.decode(responseString);
    print("=================");
    print(responseString);
    print("=================");
    print(response.statusCode);
    print("=================");
    if (response.statusCode == 200) {
      return UploadModel.fromJson(jsonDecode(responseString));
    }
    return null;
  } catch (e) {
    rethrow;
  }
}

//get all staff
Future<StaffsModel?> getStaffsService({String? search}) async {
  String url = "${BASE_URL}/staff?search=$search";
  try {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return StaffsModel.fromJson(jsonDecode(response.body));
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    rethrow;
  }
}

//get one staff
Future<StaffModel?> getStaffByIdService({required String id}) async {
  String url = "${BASE_URL}/staff/$id";
  try {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return StaffModel.fromJson(jsonDecode(response.body));
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    rethrow;
  }
}

//check email
Future<String> checkEmailService({required String email}) async {
  String url = "${BASE_URL}/staff/check/email/$email";
  try {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return "no";
    } else {
      return "yes";
    }
  } catch (e) {
    rethrow;
  }
}

//block
Future<String> blockStaffService(
    {required String id, required int status}) async {
  String url = "${BASE_URL}/staff/$id";
  Map body = {
    "blocked": status,
  };
  try {
    String token = await StorageManager.readData("token");
    var response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return "success";
    } else {
      print("Error: ${response.statusCode}");
      return "failed";
    }
  } catch (e) {
    rethrow;
  }
}

//update staff
Future<String> updateStaffService({
  required String id,
  required String name,
  required String lastName,
  required String gender,
  required String phoneNumber,
  required String email,
  String? image,
  required String birthDate,
  String? address,
}) async {
  String url = "${BASE_URL}/staff/$id";
  Map body = {
    "name": name,
    "lastName": lastName,
    "gender": gender,
    "phoneNumber": phoneNumber,
    "email": email,
    "image": image,
    "birthDate": birthDate,
    "address": address,
  };
  try {
    String token = await StorageManager.readData("token");
    var response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return "success";
    } else {
      print("Error: ${response.statusCode}");
      return "failed";
    }
  } catch (e) {
    rethrow;
  }
}

//change password
Future<String> changePasswordService({
  required String id,
  required String oldPassword,
  required String newPassword,
}) async {
  String url = "${BASE_URL}/staff/update/password/$id";
  Map body = {
    "oldPassword": oldPassword,
    "newPassword": newPassword,
  };
  try {
    String token = await StorageManager.readData("token");
    var response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return "success";
    } else if (response.statusCode == 202) {
      return "incorrect";
    } else {
      print("Error: ${response.statusCode}");
      return "failed";
    }
  } catch (e) {
    rethrow;
  }
}

//reset password
Future<String> resetPasswordService({
  required String email,
  required String newPassword,
}) async {
  String url = "${BASE_URL}/staff/reset/password";
  Map body = {
    "email": email,
    "newPassword": newPassword,
  };
  try {
    var response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return "success";
    } else {
      print("Error: ${response.statusCode}");
      return "failed";
    }
  } catch (e) {
    rethrow;
  }
}
