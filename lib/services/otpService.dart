import 'package:bounchan_hotel_admin_app/constants/string.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//send otp service
Future<String> sendOtpService({required String email}) async {
  String url = "${BASE_URL}/otp";
  try {
    Map body = {"email": email};
    print(body);
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body));
    print(response.statusCode);
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

//confirm otp service
Future<String> confirmOtpService({
  required String email,
  required String otp,
}) async {
  String url = "${BASE_URL}/otp/confirm";
  try {
    Map body = {"email": email, "otp": otp};

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
