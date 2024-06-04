import 'package:bounchan_hotel_admin_app/constants/string.dart';
import 'package:bounchan_hotel_admin_app/models/roomTypeModel.dart';
import 'package:bounchan_hotel_admin_app/models/roomTypesModel.dart';
import 'package:bounchan_hotel_admin_app/utils/storageManager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//create room type
Future<String> createRoomTypeService(
    {required String name, required String image}) async {
  String url = "${BASE_URL}/room-type";
  try {
    Map body = {
      "name": name,
      "image": image,
    };
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body));
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

//get room types
Future<RoomTypesModel?> getRoomTypesService() async {
  String url = "${BASE_URL}/room-type";
  try {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return RoomTypesModel.fromJson(jsonDecode(response.body));
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    rethrow;
  }
}

//get one room type
Future<RoomTypeModel?> getRoomTypeByIdService({required String id}) async {
  String url = "${BASE_URL}/room-type/$id";
  try {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return RoomTypeModel.fromJson(jsonDecode(response.body));
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    rethrow;
  }
}

//check room type
Future<String> checkRoomTypeService({required String roomType}) async {
  String url = "${BASE_URL}/room-type/check-room-type/$roomType";
  try {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
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

//update
Future<String> updateRoomTypeService(
    {required String id, required String name, required String image}) async {
  String url = "${BASE_URL}/room-type/$id";
  Map body = {"name": name, "image": image};
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
