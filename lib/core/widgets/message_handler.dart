// Manejador de mensajes usando another_flushbar para mostrar mensajes amigables
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class MessageHandler {
  static void showLoading(BuildContext context, String message) {
    Flushbar(
      message: message,
      showProgressIndicator: true,
      isDismissible: false,
      duration: const Duration(seconds: 2),
    ).show(context);
  }

  static void showError(BuildContext context, String message) {
    Flushbar(
      message: message,
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  static void showSuccess(BuildContext context, String message) {
    Flushbar(
      message: message,
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    ).show(context);
  }
}
