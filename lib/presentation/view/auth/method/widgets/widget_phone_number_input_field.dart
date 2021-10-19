import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/auth/method/auth_method_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetPhoneNumberInputField extends ViewModelWidget<AuthMethodViewModel> {
  @override
  Widget build(BuildContext context, AuthMethodViewModel viewModel) {
    return TextFormField(
      onChanged: (s) => viewModel.notifyListeners(),
      controller: viewModel.phoneNumberController,
      autofocus: false,
      style: TextStyle(
        fontSize: 28,
        color: AppColors.white,
        fontWeight: FontWeight.w200,
      ),
      keyboardType: TextInputType.phone,
      cursorColor: AppColors.white,
      cursorWidth: 1,
      decoration: InputDecoration(
        prefix: Text('+'),
        fillColor: AppColors.white,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.white, width: 0.5)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.gray, width: 0.5)),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(15),
      ],
      textInputAction: TextInputAction.done,
    );
  }
}
