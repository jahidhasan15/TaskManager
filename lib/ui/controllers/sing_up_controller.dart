import 'package:get/get.dart';
import 'package:tmgpjme/data/model/network_response.dart';
import 'package:tmgpjme/data/services/network_caller.dart';
import 'package:tmgpjme/data/utills/urls.dart';

class SingUpController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  String _successMassage = 'New User Created';

  String get successMassage => _successMassage;

  Future<bool> singUp(
    String email,
    String firstName,
    String lastName,
    String mobileNumber,
    String password,
  ) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobileNumber,
      "password": password,
      "photo": ""
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.registration,
      body: requestBody,
    );

    if (response.issucces) {
      _successMassage = successMassage;
      isSuccess = true;
    } else {
      _errorMassage = response.errormassage;
      _inProgress = false;
      update();
    }
    return isSuccess;
  }
}
