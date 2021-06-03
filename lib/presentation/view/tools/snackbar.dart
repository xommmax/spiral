import 'package:dairo/presentation/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static showSnackBarError(String message) => _showError('Error', message);

  static _showError(String title, String description) =>
      Get.snackbar(title, description,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(16),
          isDismissible: true,
          animationDuration: Duration(milliseconds: 100),
          backgroundColor: Colors.red,
          colorText: AppColors.white);
}
