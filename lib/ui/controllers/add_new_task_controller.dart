import 'package:get/get.dart';
import 'package:tmgpjme/data/model/network_response.dart';
import 'package:tmgpjme/data/services/network_caller.dart';
import 'package:tmgpjme/data/utills/urls.dart';

class AddNewTaskController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  String _successMassage = 'New Task Added';

  String get successMassage => _successMassage;

  Future<bool> newTaskAdd(String title, String Desciption) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "title": title,
      "description": Desciption,
      "status": "New"
    };

    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createTask, body: requestBody);

    if (response.issucces) {
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
