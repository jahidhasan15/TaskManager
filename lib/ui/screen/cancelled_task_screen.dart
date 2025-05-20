import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmgpjme/ui/controllers/cancelled_task_controller.dart';
import 'package:tmgpjme/ui/widget/centered_circular_progress_indicator.dart';
import 'package:tmgpjme/ui/widget/showsnackber_massage.dart';
import 'package:tmgpjme/ui/widget/task_listcard.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  final CancelledTaskController _cancelledTaskController =
      Get.find<CancelledTaskController>();

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    final textheme = Theme.of(context).textTheme;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getCancelledTaskList();
        },
        child: Column(
          children: [
            Expanded(
              child: GetBuilder<CancelledTaskController>(
                  builder: (cancelledTaskController) {
                return Visibility(
                  visible: !cancelledTaskController.inProgress,
                  replacement: const CanteredCircularProgressIndicator(),
                  child: ListView.separated(
                    itemCount: cancelledTaskController.cancelledTaskList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TaskListCard(
                        textheme: textheme,
                        taskModel:
                            cancelledTaskController.cancelledTaskList[index],
                        onRrefresh: _getCancelledTaskList,
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

  Future<void> _getCancelledTaskList() async {
    final result = await _cancelledTaskController.getCancelledTaskList();
    if (result == false) {
      showSnackBerMassage(
          context, _cancelledTaskController.errorMassage!, true);
    }
  }
}
