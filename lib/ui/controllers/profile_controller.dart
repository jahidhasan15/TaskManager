import 'package:get/get.dart';
import 'package:tmgpjme/data/model/network_response.dart';
import 'package:tmgpjme/data/model/userdata.dart';
import 'package:tmgpjme/data/services/network_caller.dart';
import 'package:tmgpjme/data/utills/urls.dart';
import 'package:tmgpjme/ui/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  String _successMassage = 'Profile has been updated!';

  String get successMassage => _successMassage;

  Future<bool> updateProfile(Map<String, dynamic> requestBody) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.profileUpdate,
      body: requestBody,
    );

    if (response.issucces) {
      UserModel userModel = UserModel.fromJson(requestBody);
      AuthController.saveUserData(userModel);
      _successMassage = successMassage;
      isSuccess = true;
    } else {
      _errorMassage = response.errormassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
