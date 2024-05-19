//get one staff
import 'package:bounchan_hotel_admin_app/constants/string.dart';
import 'package:bounchan_hotel_admin_app/models/memberModel.dart';
import 'package:bounchan_hotel_admin_app/models/membersModel.dart';
import 'package:bounchan_hotel_admin_app/utils/storageManager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//get members
Future<MembersModel?> getMembersService() async {
  String url = "${BASE_URL}/member";
  try {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return MembersModel.fromJson(jsonDecode(response.body));
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    rethrow;
  }
}

//get one member
Future<MemberModel?> getMemberByIdService({required String id}) async {
  String url = "${BASE_URL}/member/$id";
  try {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return MemberModel.fromJson(jsonDecode(response.body));
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    rethrow;
  }
}

//block
Future<String> blockMemberService(
    {required String id, required int status}) async {
  String url = "${BASE_URL}/member/$id";
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
