import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmgpjme/data/model/network_response.dart';
import 'package:tmgpjme/data/services/network_caller.dart';
import 'package:tmgpjme/data/utills/urls.dart';

class ForgotNewPasswordController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;
  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  Future<bool> setNewPassword(Map<String, dynamic> requestBody) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.recoverResetPassWord,
      body: requestBody,
    );
    if (response.issucces) {
      isSuccess = true;
    } else {
      _errorMassage = response.errormassage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
