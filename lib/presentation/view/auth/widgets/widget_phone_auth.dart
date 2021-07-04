import 'package:dairo/presentation/view/auth/auth_viewmodel.dart';
import 'package:dairo/presentation/view/auth/widgets/button_signup.dart';
import 'package:dairo/presentation/view/auth/widgets/widget_input_verification_code.dart';
import 'package:dairo/presentation/view/auth/widgets/widget_phone_number_input_field.dart';
import 'package:dairo/presentation/view/base/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetPhoneAuth extends ViewModelWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context, AuthViewModel viewModel) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !viewModel.viewData.isCodeSent
              ? WidgetPhoneNumberInputField(
                  onCountryCodeChanged: viewModel.onCountryCodeChanged,
                  controller: viewModel.phoneNumberController,
                )
              : WidgetInputVerificationCode(),
          !viewModel.isBusy
              ? !viewModel.viewData.isCodeSent
                  ? ButtonSignUp()
                  : SizedBox.shrink()
              : Container(
                  height: 44,
                  margin: EdgeInsets.only(top: 24),
                  child: Center(
                    child: ProgressBar(),
                  ),
                ),
        ],
      );
}
