import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmgpjme/app.dart';
import 'package:tmgpjme/data/model/network_response.dart';
import 'package:tmgpjme/ui/controllers/auth_controller.dart';
import 'package:tmgpjme/ui/screen/sign_in_screen.dart';
import 'package:flutter/foundation.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'token': AuthController.accessToken.toString(),
      };
      printRequest(url,null,headers);
      Response response = await get(uri, headers: headers,);
      printResponse(url, response);


      if (response.statusCode == 200) {
        final deCodeData = jsonDecode(response.body);
        return NetworkResponse(
          issucces: true,
          stauscode: response.statusCode,
          responsedata: deCodeData,
        );
      } else if (response.statusCode == 401) {
        _moveToLogIn();
        return NetworkResponse(
          issucces: false,
          stauscode: response.statusCode,
          errormassage: 'Unauthtecated',
        );
      } else {
        return NetworkResponse(
          issucces: false,
          stauscode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        issucces: false,
        stauscode: -1,
        errormassage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'token': AuthController.accessToken.toString(),
      };
      printRequest(url,body,headers);
      Response response = await post(
        uri,
        body: jsonEncode(body),
        headers: headers,
      );
      printResponse(url, response);
      if (response.statusCode == 200) {
        final deCodeData = jsonDecode(response.body);

        if (deCodeData['status'] == 'fail') {
          return NetworkResponse(
            issucces: false,
            stauscode: response.statusCode,
            responsedata: deCodeData['data'],
          );
        }

        return NetworkResponse(
          issucces: true,
          stauscode: response.statusCode,
          responsedata: deCodeData,
        );
      } else if (response.statusCode == 401) {
        return NetworkResponse(
          issucces: false,
          stauscode: response.statusCode,
          errormassage: 'Unauthtecated',
        );
      } else {
        return NetworkResponse(
          issucces: false,
          stauscode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        issucces: false,
        stauscode: -1,
        errormassage: e.toString(),
      );
    }
  }

 static Future<void> _moveToLogIn() async {
    Navigator.pushAndRemoveUntil(TaskManagerMP.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => SignInScreen()), (p) => false);
  }

  static void printRequest(String url,Map<String,dynamic>?body,Map<String,dynamic>?headers){

    debugPrint('Request: url:$url\nBody:$body\nheaders:$headers');


  }
  static void printResponse(String url,Response response){

    debugPrint('url:$url\ncode:${response.statusCode}\nbody:${response.body}');


  }




}
