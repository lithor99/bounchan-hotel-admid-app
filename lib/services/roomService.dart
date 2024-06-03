//get one staff
import 'package:bounchan_hotel_admin_app/constants/string.dart';
import 'package:bounchan_hotel_admin_app/models/roomManualModel.dart';
import 'package:bounchan_hotel_admin_app/models/roomModel.dart';
import 'package:bounchan_hotel_admin_app/models/roomsModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//create room
Future<String> createRoomService(
    {required String roomNo,
    required String roomTypeId,
    required String price,
    required String description,
    required List<String?> images}) async {
  String url = "${BASE_URL}/room";
  try {
    Map body = {
      "roomNo": roomNo,
      "roomTypeId": roomTypeId,
      "price": price,
      "description": description,
      "images": images
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

//get rooms
Future<RoomsModel?> getRoomsService({String? search}) async {
  String url = "${BASE_URL}/room?search=$search";
  try {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return RoomsModel.fromJson(jsonDecode(response.body));
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    rethrow;
  }
}

//get rooms manual book
Future<RoomsManualModel?> getRoomsManualService({String? search}) async {
  String url = "${BASE_URL}/room/member?search=$search";
  try {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return RoomsManualModel.fromJson(jsonDecode(response.body));
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    rethrow;
  }
}

//get one room
Future<RoomModel?> getRoomByIdService({required String id}) async {
  String url = "${BASE_URL}/room/$id";
  try {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return RoomModel.fromJson(jsonDecode(response.body));
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    rethrow;
  }
}

//update
Future<String> updateRoomService(
    {required String id,
    String? roomNo,
    required String roomTypeId,
    required int price,
    required String description,
    required List<String?> images}) async {
  String url = "${BASE_URL}/room/$id";
  Map body = {};
  try {
    if (roomNo != null) {
      body = {
        "roomNo": roomNo,
        "roomTypeId": roomTypeId,
        "price": price,
        "description": description,
        "images": images,
      };
    } else {
      body = {
        "roomTypeId": roomTypeId,
        "price": price,
        "description": description,
        "images": images,
      };
    }
    // print("------------------------ $id");
    // print(body);
    // print("------------------------");
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

//update
Future<String> deleteRoomImageService({required String id}) async {
  String url = "${BASE_URL}/room/image/$id";
  try {
    // print("------------------------ $id");
    // print(body);
    // print("------------------------");
    var response = await http.delete(
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
