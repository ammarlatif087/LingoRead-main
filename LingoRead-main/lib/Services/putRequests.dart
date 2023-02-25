import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lingoread/Utils/app_constants.dart';

import 'ResponseModel/resonseModel.dart';

class APIsCallPut {
  static Future<ResponseModel> updateRequestWithId(
      String requestUrl, dynamic data, String id) async {
    try {
      final response = await http.put(
        Uri.parse(AppConst.apiLink + requestUrl + "/" + id),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': AppConst.tokenType + " " + AppConst.accessToken
        },
        body: jsonEncode(data),
      );
      print(data);

      final res =
          ResponseModel(statusCode: response.statusCode, data: response.body);

      return res;
    } catch (e) {
      final res = ResponseModel(statusCode: -1, data: e.toString());
      return res;
    }
  }

  static String method2() {
    /*...*/
    return "Some string";
  }
}
