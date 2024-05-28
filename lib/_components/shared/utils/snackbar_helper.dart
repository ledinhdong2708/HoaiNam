import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

void showErrorMessage(BuildContext context, {required String message}) {
  QuickAlert.show(context: context, type: QuickAlertType.error, text: message);
  // final snackBar = SnackBar(
  //   content: Text(message, style: TextStyle(color: Colors.white),),
  //   backgroundColor: Colors.red,
  // );
  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSuccessMessage(BuildContext context, {required String message}) {
  // final snackBar = SnackBar(content: Text(message));
  // ScaffoldMessenger.of(context).showSnackBar(snackBar);

  QuickAlert.show(
      context: context, type: QuickAlertType.success, text: message);
}
