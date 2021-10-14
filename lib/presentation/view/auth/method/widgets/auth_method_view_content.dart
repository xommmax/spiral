import 'dart:io';

import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/auth/method/auth_method_viewmodel.dart';
import 'package:dairo/presentation/view/auth/method/widgets/widget_input_verification_code.dart';
import 'package:dairo/presentation/view/auth/method/widgets/widget_phone_number_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:stacked/stacked.dart';

class AuthMethodViewContent extends ViewModelWidget<AuthMethodViewModel> {
  @override
  Widget build(BuildContext context, AuthMethodViewModel viewModel) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 64, right: 64, top: 72),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Spiral",
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: 'Sofia-Pro',
                      // fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),
                  (!viewModel.viewData.isCodeSent)
                      ? WidgetPhoneNumberInputField()
                      : WidgetInputVerificationCode(),
                  SizedBox(height: 8),
                  if (!viewModel.viewData.isCodeSent)
                    TextButton(
                      onPressed: viewModel.onPhoneNextClicked,
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 36)),
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: Text(
                        Strings.next,
                        style: TextStyle(color: AppColors.darkAccentColor),
                      ),
                    ),
                  if ((Platform.isAndroid || Platform.isIOS) &&
                      !viewModel.viewData.isCodeSent)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        Strings.or,
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  if (Platform.isAndroid && !viewModel.viewData.isCodeSent)
                    SignInButton(
                      Buttons.Google,
                      onPressed: viewModel.onGoogleSignUpClicked,
                      text: Strings.loginWithGoogle,
                    ),
                  if (Platform.isIOS && !viewModel.viewData.isCodeSent)
                    SignInButton(
                      Buttons.Apple,
                      onPressed: viewModel.onAppleSignUpClicked,
                      text: Strings.loginWithApple,
                    ),
                ],
              ),
            ),
          ),
        ),
      );
}
