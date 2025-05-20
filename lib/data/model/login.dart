import 'package:tmgpjme/data/model/userdata.dart';

class LoginModel {
  String? status;
  String? token;
  UserModel? data;

  LoginModel({this.status, this.token, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    data = json['data'] != null ? new UserModel.fromJson(json['data']) : null;
  }
}
