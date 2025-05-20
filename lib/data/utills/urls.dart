class Urls {
  static const String _baseUrls = 'https://task.teamrabbil.com/api/v1';

  static const String registration = '$_baseUrls/registration';
  static const String login = '$_baseUrls/login';
  static const String createTask = '$_baseUrls/createTask';
  static const String newList = '$_baseUrls/listTaskByStatus/New';
  static const String completedTaskList =
      '$_baseUrls/listTaskByStatus/Completed';
  static const String cancelledTaskList =
      '$_baseUrls/listTaskByStatus/Cancelled';
  static const String progressTaskList = '$_baseUrls/listTaskByStatus/Progress';
  static const String taskStatusCount = '$_baseUrls/taskStatusCount';

  static const String recoverResetPassWord = '$_baseUrls/RecoverResetPass';
  static const String profileUpdate = '$_baseUrls/profileUpdate';


  static String forgotEmail(String email) =>
      '$_baseUrls/RecoverVerifyEmail/$email';

  static String getVerifyOTp(String email, String otp) =>
      '$_baseUrls/RecoverVerifyOTP/$email/$otp';

  static String changeStatus(String taskId, String status) =>
      '$_baseUrls/updateTaskStatus/$taskId/$status';

  static String deletedStatus(String taskId) => '$_baseUrls/deleteTask/$taskId';
}
