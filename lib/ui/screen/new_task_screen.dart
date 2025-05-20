import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:tmgpjme/data/model/task_status_model.dart';
import 'package:tmgpjme/ui/controllers/new_task_list_controller.dart';
import 'package:tmgpjme/ui/controllers/status_count_controller.dart';
import 'package:tmgpjme/ui/screen/add_new_taskscreen.dart';
import 'package:tmgpjme/ui/widget/centered_circular_progress_indicator.dart';
import 'package:tmgpjme/ui/widget/showsnackber_massage.dart';
import 'package:tmgpjme/ui/widget/task_listcard.dart';
import 'package:tmgpjme/ui/widget/tasksummary.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final NewTaskListController _newTaskListController =
      Get.find<NewTaskListController>();
  final StatusCountController _statusCountController =
      Get.find<StatusCountController>();

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
    _getTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getTaskStatusCount();
        },
        child: Column(
          children: [
            _buildSummarySection(textTheme),
            const SizedBox(height: 5),
            Expanded(
              child: GetBuilder<NewTaskListController>(
                  builder: (newListController) {
                return Visibility(
                  visible: !newListController.inProgress,
                  replacement: const CanteredCircularProgressIndicator(),
                  child: ListView.separated(
                    itemCount: newListController.taskList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TaskListCard(
                        textheme: textTheme,
                        taskModel: newListController.taskList[index],
                        onRrefresh: _getNewTaskList,
                      );
                    },
                    separatorBuilder: (BuildContext context, index) {
                      return const Divider(
                        thickness: double.maxFinite,
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummarySection(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          GetBuilder<StatusCountController>(builder: (statusCountController) {
        return Visibility(
          visible: !statusCountController.inProgress,
          replacement: const CanteredCircularProgressIndicator(),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _getTaskSummaryCardList(),
            ),
          ),
        );
      }),
    );
  }

  List<TaskSummary> _getTaskSummaryCardList() {
    List<TaskSummary> taskSummaryCardList = [];
    for (TaskStatusModel t in _statusCountController.taskStatusList) {
      taskSummaryCardList.add(TaskSummary(
        title: t.sId!,
        count: t.sum!,
      ));
    }
    return taskSummaryCardList;
  }

  Future<void> _onTapAddNewTask() async {
    final bool? result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));
    if (result == true) {
      _getNewTaskList();
    }
  }

  Future<void> _getNewTaskList() async {
    final result = await _newTaskListController.getNewTaskList();
    if (result == false) {
      showSnackBerMassage(context, _newTaskListController.errorMassage!, true);
    }
  }

  Future<void> _getTaskStatusCount() async {
    final result = await _statusCountController.getTaskStatusCount();
    if (result == false) {
      final message = _statusCountController.errorMassage ?? 'Unknown error';
      showSnackBerMassage(context, message, true);
    }
  }
}
