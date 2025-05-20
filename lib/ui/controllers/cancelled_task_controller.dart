import 'package:get/get.dart';
import 'package:tmgpjme/data/model/network_response.dart';
import 'package:tmgpjme/data/model/task_list_model.dart';
import 'package:tmgpjme/data/model/task_model.dart';
import 'package:tmgpjme/data/services/network_caller.dart';
import 'package:tmgpjme/data/utills/urls.dart';

class CancelledTaskController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  List<TaskModel> _cancelledTaskList = [];

  List<TaskModel> get cancelledTaskList => _cancelledTaskList;

  Future<bool> getCancelledTaskList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.cancelledTaskList);

    if (response.issucces) {
      TaskListModel taskListModel =
          TaskListModel.fromJson(response.responsedata);
      _cancelledTaskList = taskListModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMassage = response.errormassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
