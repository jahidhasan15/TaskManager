import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmgpjme/ui/controllers/completed_task_controller.dart';
import 'package:tmgpjme/ui/widget/centered_circular_progress_indicator.dart';
import 'package:tmgpjme/ui/widget/showsnackber_massage.dart';
import 'package:tmgpjme/ui/widget/task_listcard.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final CompletedTaskController _completedTaskController =
      Get.find<CompletedTaskController>();

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    final textheme = Theme.of(context).textTheme;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getCompletedTaskList();
        },
        child: Column(
          children: [
            Expanded(
              child: GetBuilder<CompletedTaskController>(
                  builder: (completedTaskController) {
                return Visibility(
                  visible: !completedTaskController.inProgress,
                  replacement: const CanteredCircularProgressIndicator(),
                  child: ListView.separated(
                    itemCount: completedTaskController.completedTaskList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TaskListCard(
                        textheme: textheme,
                        taskModel:
                            completedTaskController.completedTaskList[index],
                        onRrefresh: _getCompletedTaskList,
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
    );
  }

  Future<void> _getCompletedTaskList() async {
    final result = await _completedTaskController.getCompletedTaskList();
    if (result == false) {
      showSnackBerMassage(
          context, _completedTaskController.errorMassage!, true);
    }
  }
}
