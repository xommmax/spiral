import 'dart:io';

import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/auth/auth_viewmodel.dart';
import 'package:dairo/presentation/view/auth/widgets/widget_phone_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:stacked/stacked.dart';

class WidgetAuthViewContent extends ViewModelWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context, AuthViewModel viewModel) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                        'lib/presentation/res/drawable/ic_auth_background.png'),
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
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text(
                                Strings.welcomeToDairo,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.black,
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
                                  color: AppColors.black,
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
                            SignInButton(
                              Buttons.Facebook,
                              onPressed: viewModel.onFacebookSignUpClocked,
                              text: Strings.loginWithFacebook,
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
