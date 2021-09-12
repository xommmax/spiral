import 'package:dairo/presentation/res/colors.dart';
import 'package:flutter/material.dart';

class CustomInputDecoration extends InputDecoration {
  CustomInputDecoration(String label)
      : super(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.accentColor),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.accentColor, width: 2)),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.accentColor, width: 1)),
        );
}
