import 'package:bounchan_hotel_admin_app/constants/string.dart';
import 'package:bounchan_hotel_admin_app/models/membersModel.dart';
import 'package:bounchan_hotel_admin_app/models/reportBookModel.dart';
import 'package:bounchan_hotel_admin_app/models/reportChartModel.dart';
import 'package:bounchan_hotel_admin_app/models/reportIncomeModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//report member
Future<MembersModel?> reportMemberService({
  required String startDate,
  required String endDate,
}) async {
  String url =
      "${BASE_URL}/report-member?startDate=$startDate&endDate=$endDate";
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

//report book
Future<ReportBookModel?> reportBookService({
  required String startDate,
  required String endDate,
  String? status,
}) async {
  String url = "${BASE_URL}/report-book?startDate=$startDate&endDate=$endDate";
  try {
    if (status != null && status != "") url += "&status=$status";
    print("url----------->: $url ");
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return ReportBookModel.fromJson(jsonDecode(response.body));
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    rethrow;
  }
}

//report income
Future<ReportIncomeModel?> reportIncomeService({
  required String startDate,
  required String endDate,
}) async {
  String url =
      "${BASE_URL}/report-income?startDate=$startDate&endDate=$endDate";
  try {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return ReportIncomeModel.fromJson(jsonDecode(response.body));
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    rethrow;
  }
}

//report chart
Future<ReportChartModel?> reportChartService({required String year}) async {
  String url = "${BASE_URL}/report-chart?year=$year";
  try {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return ReportChartModel.fromJson(jsonDecode(response.body));
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    rethrow;
  }
}
