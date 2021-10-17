import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/auth/method/auth_method_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';

class WidgetInputVerificationCode extends ViewModelWidget<AuthMethodViewModel> {
  @override
  Widget build(BuildContext context, AuthMethodViewModel viewModel) => Padding(
        padding: EdgeInsets.only(bottom: 156),
        child: PinCodeTextField(
          appContext: context,
          length: 6,
          onChanged: (_) {},
          onCompleted: viewModel.onCodeVerificationRetrieved,
          autoFocus: false,
          animationType: AnimationType.scale,
          animationDuration: Duration(milliseconds: 150),
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            fieldHeight: 50,
            fieldWidth: 40,
            activeColor: AppColors.darkGray,
            selectedColor: AppColors.white,
            inactiveColor: AppColors.gray,
          ),
        ),
      );
}
