
import 'package:get/get.dart';
import 'package:tmgpjme/data/model/login.dart';
import 'package:tmgpjme/data/model/network_response.dart';
import 'package:tmgpjme/data/services/network_caller.dart';
import 'package:tmgpjme/data/utills/urls.dart';
import 'package:tmgpjme/ui/controllers/auth_controller.dart';

class SingInController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;
  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  Future<bool> sinIn(String email, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.login,
      body: requestBody,
    );
    if (response.issucces) {
      LoginModel loginModel = LoginModel.fromJson(response.responsedata);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data!);
      isSuccess = true;
    } else {
      _errorMassage = response.errormassage;
      _inProgress = false;
      update();
    }
    return isSuccess;
  }
}
