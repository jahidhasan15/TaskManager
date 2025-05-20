import 'package:get/get.dart';
import 'package:tmgpjme/data/model/network_response.dart';
import 'package:tmgpjme/data/model/task_list_model.dart';
import 'package:tmgpjme/data/model/task_model.dart';
import 'package:tmgpjme/data/services/network_caller.dart';
import 'package:tmgpjme/data/utills/urls.dart';

class NewTaskListController extends GetxController{

  bool _inProgress=false;

  bool get inProgress=>_inProgress;

  String?  _errorMassage;

  String? get errorMassage=>_errorMassage;

  List<TaskModel> _taskList=[];

  List <TaskModel> get taskList=>_taskList;



  Future<bool> getNewTaskList() async {
    bool isSuccess=false;
   _inProgress = true;
    update();

    NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.newList);

    if (response.issucces) {
      TaskListModel taskListModel =
      TaskListModel.fromJson(response.responsedata);
      _taskList = taskListModel.taskList ?? [];
      isSuccess=true;
    } else {
      _errorMassage =response.errormassage;
    }
   _inProgress=false;
    update();
    return isSuccess;
  }










}