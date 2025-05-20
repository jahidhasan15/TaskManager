import 'package:get/get.dart';
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

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(SingInController());
    Get.put(NewTaskListController());
    Get.put(SingUpController());
    Get.put(AddNewTaskController());
    Get.put(CompletedTaskController());
    Get.put(CancelledTaskController());
    Get.put(ProgressTaskController());
    Get.put(ProfileController());
    Get.put(ForgotOtpController());
    Get.put(ForgotNewPasswordController());
    Get.put(ForgotEmailController());
    Get.put(StatusChangeController());
    Get.put(TaskDeletedController());
    Get.put(StatusCountController());
  }
}