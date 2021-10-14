import 'dart:io';

import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/auth/method/auth_method_viewmodel.dart';
import 'package:dairo/presentation/view/auth/widgets/widget_phone_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:stacked/stacked.dart';

class AuthMethodViewContent extends ViewModelWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context, AuthViewModel viewModel) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 71,
                          right: 71,
                          bottom: 71,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 101,
                              width: 101,
                              margin: EdgeInsets.only(top: 180),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text(
                                Strings.welcomeToDairo,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 54),
                            ),
                            WidgetPhoneAuth(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 21.0),
                              child: Text(
                                Strings.or,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            Platform.isAndroid
                                ? SignInButton(
                                    Buttons.Google,
                                    onPressed: viewModel.onGoogleSignUpClicked,
                                    text: Strings.loginWithGoogle,
                                  )
                                : SignInButton(
                                    Buttons.Apple,
                                    onPressed: viewModel.onAppleSignUpClicked,
                                    text: Strings.loginWithApple,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          top: false,
        ),
      );
}
