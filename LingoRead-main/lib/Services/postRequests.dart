import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lingoread/Utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ResponseModel/resonseModel.dart';

class APIsCallPost {
  static Future<ResponseModel> submitRequest(
      String requestUrl, dynamic data) async {
    try {
      final response = await http.post(
        Uri.parse(AppConst.apiLink),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: data,
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        return ResponseModel(statusCode: response.statusCode, data: res);
        ;
      } else if (response.statusCode == 404) {
        return ResponseModel(
            statusCode: response.statusCode, data: response.body);
      } else {
        return ResponseModel(statusCode: 505, data: "Something went wrong");
      }

      // final res =
      //     ResponseModel(statusCode: response.statusCode, data: response.body);

      // return res;
    } catch (e) {
      final res = ResponseModel(statusCode: -1, data: e.toString());
      return res;
    }
  }

  static Future<ResponseModel> submitRequestWithAuth(
      String requestUrl, dynamic data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? authKey = prefs.getString('Authorization');

      print(authKey);

      if (authKey != null && authKey != "") {
        final response = await http.post(
          Uri.parse(AppConst.apiLink),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': "Bearer " + authKey
          },
          body: data,
        );
        print(response.body);

        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          return ResponseModel(statusCode: response.statusCode, data: res);
        } else if (response.statusCode == 401) {
          return ResponseModel(
              statusCode: 401, data: "Authorization Denied, Login Again");
        } else if (response.statusCode == 209) {
          return ResponseModel(statusCode: 209, data: "Incorrect Data");
        } else {
          return ResponseModel(statusCode: 505, data: "Something went wrong");
        }
      } else {
        return ResponseModel(
            statusCode: 401, data: "Authorization Denied, Login Again");
      }
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
