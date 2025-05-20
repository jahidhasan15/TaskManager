import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmgpjme/data/model/task_model.dart';
import 'package:tmgpjme/ui/controllers/status_change_controller.dart';
import 'package:tmgpjme/ui/controllers/task_deleted_controller.dart';
import 'package:tmgpjme/ui/widget/centered_circular_progress_indicator.dart';
import 'package:tmgpjme/ui/widget/showsnackber_massage.dart';

class TaskListCard extends StatefulWidget {
  const TaskListCard({
    super.key,
    required this.textheme,
    required this.taskModel,
    required this.onRrefresh,
  });

  final TaskModel taskModel;
  final TextTheme textheme;
  final VoidCallback onRrefresh;

  @override
  State<TaskListCard> createState() => _TaskListCardState();
}

class _TaskListCardState extends State<TaskListCard> {
  final StatusChangeController _statusChangeController =
      Get.find<StatusChangeController>();
  final TaskDeletedController _taskDeletedController =
      Get.find<TaskDeletedController>();

  @override
  void initState() {
    _selectedStatus = widget.taskModel.status!;
    super.initState();
  }

  String _selectedStatus = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(
            widget.taskModel.title ?? '',
            style: widget.textheme.displayMedium,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.taskModel.description ?? ''),
              Text('Date:${widget.taskModel.createdDate}'),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(
                    label: Text(widget.taskModel.status!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    labelStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Wrap(
                    children: [
                      GetBuilder<StatusChangeController>(
                          builder: (statusCHGController) {
                        return Visibility(
                          visible: !statusCHGController.inProgress,
                          replacement:
                              const CanteredCircularProgressIndicator(),
                          child: IconButton(
                            onPressed: _onTapEditButton,
                            icon: const Icon(Icons.edit_calendar_outlined),
                          ),
                        );
                      }),
                      GetBuilder<TaskDeletedController>(
                          builder: (tkDeletedController) {
                        return Visibility(
                          visible: !tkDeletedController.inProgress,
                          replacement:
                              const CanteredCircularProgressIndicator(),
                          child: IconButton(
                            onPressed: _deletedStatus,
                            icon: const Icon(Icons.delete),
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapEditButton() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              'New',
              'Completed',
              'Cancelled',
              'Progress',
            ].map((e) {
              return ListTile(
                onTap: () {
                  _changeStatus(e);
                  Navigator.pop(context);
                },
                selected: _selectedStatus == e,
                trailing: _selectedStatus == e ? const Icon(Icons.check) : null,
                title: Text(e),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okey'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _changeStatus(String newStatus) async {
    final result = await _statusChangeController.changeStatus(
      newStatus,
      widget.taskModel.sId!,
    );
    if (result) {
      widget.onRrefresh();
    } else {
      showSnackBerMassage(context, _statusChangeController.errorMassage!, true);
    }
  }

  Future<void> _deletedStatus() async {
    final result =
        await _taskDeletedController.deletedStatus(widget.taskModel.sId!);
    if (result) {
      widget.onRrefresh();
    } else {
      showSnackBerMassage(context, _taskDeletedController.errorMassage!, true);
    }
  }
}
