import 'package:get/get.dart';
import 'package:tmgpjme/data/model/network_response.dart';
import 'package:tmgpjme/data/model/task_status_count_model.dart';
import 'package:tmgpjme/data/model/task_status_model.dart';
import 'package:tmgpjme/data/services/network_caller.dart';
import 'package:tmgpjme/data/utills/urls.dart';

class StatusCountController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  List<TaskStatusModel> _taskStatusList = [];

  List<TaskStatusModel> get taskStatusList => _taskStatusList;

  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  Future<bool> getTaskStatusCount() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskStatusCount);
    if (response.issucces) {
      TaskStatusCountModel taskStatusCountModel =
          TaskStatusCountModel.fromJson(response.responsedata);
      _taskStatusList = taskStatusCountModel.taskStatusCountList ?? [];
      isSuccess = true;
    } else {
      _errorMassage = response.errormassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
