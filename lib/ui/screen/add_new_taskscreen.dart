import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmgpjme/ui/controllers/add_new_task_controller.dart';
import 'package:tmgpjme/ui/widget/centered_circular_progress_indicator.dart';
import 'package:tmgpjme/ui/widget/screen_background.dart';
import 'package:tmgpjme/ui/widget/showsnackber_massage.dart';
import 'package:tmgpjme/ui/widget/tmappber.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AddNewTaskController _addNewTaskController =
      Get.find<AddNewTaskController>();

  bool _shouldRefreshPreviousPage = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        Navigator.pop(context, _shouldRefreshPreviousPage);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const TmAppBer(),
        body: ScreenBackgournd(
          screenSize: screenSize,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 75),
                    Text(
                      'Add New Task',
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _titleTEController,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'enter the value';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _descriptionTEController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Description',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'enter the value';
                        }
                        if (value!.length <= 20) {
                          return 'enter the 50 ca.. description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    GetBuilder<AddNewTaskController>(builder: (controller) {
                      return Visibility(
                        visible: !controller.inProgress,
                        replacement: const CanteredCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: _onTapTaskAddButton,
                          child: const Icon(Icons.arrow_forward_ios_sharp),
                        ),
                      );
                    }),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapTaskAddButton() {
    if (_formKey.currentState!.validate()) {
      _newTaskAdd();
    }
  }

  Future<void> _newTaskAdd() async {
    final result = await _addNewTaskController.newTaskAdd(
        _titleTEController.text.trim(), _descriptionTEController.text.trim());
    if (result) {
      _shouldRefreshPreviousPage = true;
      _clearTextFiled();
      showSnackBerMassage(context, _addNewTaskController.successMassage);
    } else {
      showSnackBerMassage(context, _addNewTaskController.errorMassage!, true);
    }
  }

  void _clearTextFiled() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }
}
