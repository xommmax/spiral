import 'package:dairo/presentation/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static showSnackBarError(String message, {String title = 'Error'}) =>
      _showError(title, message);

  static showSnackBarSuccess(String message, {String title = 'Success'}) =>
      _showSuccess(title, message);

  static _showError(String title, String description) => Get.snackbar(
        title,
        description,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(0),
        isDismissible: true,
        animationDuration: Duration(milliseconds: 300),
        borderRadius: 0,
        backgroundColor: AppColors.darkestGray,
        titleText: Text(
          title,
          style: TextStyle(
            color: AppColors.errorRedColor,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        colorText: AppColors.white,
      );

  static _showSuccess(String title, String description) => Get.snackbar(
        title,
        description,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(0),
        isDismissible: true,
        animationDuration: Duration(milliseconds: 100),
        borderRadius: 0,
        backgroundColor: AppColors.darkestGray,
        colorText: AppColors.white,
      );
}
