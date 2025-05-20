import 'package:get/get.dart';
import 'package:tmgpjme/data/model/network_response.dart';
import 'package:tmgpjme/data/model/task_list_model.dart';
import 'package:tmgpjme/data/model/task_model.dart';
import 'package:tmgpjme/data/services/network_caller.dart';
import 'package:tmgpjme/data/utills/urls.dart';

class ProgressTaskController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  List<TaskModel> _progressTaskList = [];

  List<TaskModel> get progressTaskList => _progressTaskList;

  Future<bool> getProgressTaskList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.progressTaskList);

    if (response.issucces) {
      TaskListModel taskListModel =
          TaskListModel.fromJson(response.responsedata);
      _progressTaskList = taskListModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMassage = response.errormassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
