import 'package:flutter/material.dart';

void showSnackBerMassage(BuildContext context,String massage,
    [bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(massage),
    backgroundColor: isError ? Colors.redAccent : null,
  ));
}
