import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/auth/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';

class WidgetInputVerificationCode extends ViewModelWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context, AuthViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: PinCodeTextField(
          appContext: context,
          length: 6,
          onChanged: (_) {},
          onCompleted: viewModel.onCodeVerificationRetrieved,
          autoFocus: true,
          animationType: AnimationType.none,
          animationDuration: Duration.zero,
          pinTheme: PinTheme(
            activeColor: AppColors.primaryColor,
            inactiveColor: AppColors.black,
            fieldHeight: 24,
            fieldWidth: 24,
          ),
        ),
      );
}
