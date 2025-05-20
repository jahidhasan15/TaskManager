import 'package:get/get.dart';
import 'package:tmgpjme/data/model/network_response.dart';
import 'package:tmgpjme/data/services/network_caller.dart';
import 'package:tmgpjme/data/utills/urls.dart';

class TaskDeletedController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  Future<bool> deletedStatus(String sId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.deletedStatus(sId!));
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
