import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmgpjme/ui/controllers/progress_task_controller.dart';
import 'package:tmgpjme/ui/widget/centered_circular_progress_indicator.dart';
import 'package:tmgpjme/ui/widget/showsnackber_massage.dart';
import 'package:tmgpjme/ui/widget/task_listcard.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  final ProgressTaskController _progressTaskController =
      Get.find<ProgressTaskController>();

  @override
  void initState() {
    super.initState();
    _getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    final textheme = Theme.of(context).textTheme;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getProgressTaskList();
        },
        child: Column(
          children: [
            Expanded(
              child: GetBuilder<ProgressTaskController>(
                  builder: (progressTaskController) {
                return Visibility(
                  visible: !progressTaskController.inProgress,
                  replacement: const CanteredCircularProgressIndicator(),
                  child: ListView.separated(
                    itemCount: progressTaskController.progressTaskList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TaskListCard(
                        textheme: textheme,
                        taskModel:
                            progressTaskController.progressTaskList[index],
                        onRrefresh: _getProgressTaskList,
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

  Future<void> _getProgressTaskList() async {
    final result = await _progressTaskController.getProgressTaskList();
    if (result == false) {
      showSnackBerMassage(context, _progressTaskController.errorMassage!, true);
    }
  }
}
