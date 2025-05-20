import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:tmgpjme/app.dart';
import 'package:tmgpjme/ui/controllers/add_new_task_controller.dart';
import 'package:tmgpjme/ui/controllers/cancelled_task_controller.dart';
import 'package:tmgpjme/ui/controllers/completed_task_controller.dart';
import 'package:tmgpjme/ui/controllers/forgot_email_controller.dart';
import 'package:tmgpjme/ui/controllers/forgot_new_password_controller.dart';
import 'package:tmgpjme/ui/controllers/forgot_otp_controller.dart';
import 'package:tmgpjme/ui/controllers/new_task_list_controller.dart';
import 'package:tmgpjme/ui/controllers/profile_controller.dart';
import 'package:tmgpjme/ui/controllers/progress_task_controller.dart';
import 'package:tmgpjme/ui/controllers/sing_in_controller.dart';
import 'package:tmgpjme/ui/controllers/sing_up_controller.dart';
import 'package:tmgpjme/ui/controllers/status_change_controller.dart';
import 'package:tmgpjme/ui/controllers/status_count_controller.dart';
import 'package:tmgpjme/ui/controllers/task_deleted_controller.dart';

void main(){
 Get.put(StatusCountController());
 Get.put(TaskDeletedController());
 Get.put(StatusChangeController());
 Get.put(ForgotEmailController());
 Get.put(ForgotNewPasswordController());
 Get.put(ForgotOtpController());
 Get.put(ProfileController());
 Get.put(ProgressTaskController());
 Get.put(CancelledTaskController());
 Get.put(CompletedTaskController());
 Get.put(AddNewTaskController());
 Get.put(SingUpController());
 Get.put(NewTaskListController());
 Get.put(SingInController());

 runApp(const TaskManagerMP());
}