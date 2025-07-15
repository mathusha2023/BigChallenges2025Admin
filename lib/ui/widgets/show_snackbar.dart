import 'package:apptomate_custom_snackbar/apptomate_custom_snackbar.dart';
import 'package:flutter/material.dart';

void _showSnackbar(BuildContext context, String message, IconData icon) {
  CustomSnackbar.show(
    context,
    message: message,
    backgroundColor: Theme.of(context).colorScheme.secondary,
    icon: icon,
    duration: const Duration(seconds: 2),
  );
}

void showSuccessSnackBar(BuildContext context, String message) {
  _showSnackbar(context, message, Icons.check_circle);
}

void showErrorSnackBar(BuildContext context, String message) {
  _showSnackbar(context, message, Icons.error);
}
