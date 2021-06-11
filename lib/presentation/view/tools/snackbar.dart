import 'package:dairo/presentation/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static showSnackBarError(String message) => _showError('Error', message);

  static showSnackBarSuccess(String message) =>
      _showSuccess('Success', message);

  static _showError(String title, String description) =>
      Get.snackbar(title, description,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(16),
          isDismissible: true,
          animationDuration: Duration(milliseconds: 100),
          backgroundColor: AppColors.errorRedColor,
          colorText: AppColors.white);

  static _showSuccess(String title, String description) =>
      Get.snackbar(title, description,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(16),
          isDismissible: true,
          animationDuration: Duration(milliseconds: 100),
          backgroundColor: Colors.green.withOpacity(0.5),
          colorText: AppColors.white);
}
