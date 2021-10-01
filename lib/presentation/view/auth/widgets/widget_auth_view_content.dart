import 'dart:io';

import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/auth/auth_viewmodel.dart';
import 'package:dairo/presentation/view/auth/widgets/widget_phone_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/link.dart';

class WidgetAuthViewContent extends ViewModelWidget<AuthViewModel> {
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Link(
                    uri: Uri.parse('https://www.spiralapp.site/privacy-policy'),
                    builder: (context, followLink) {
                      return RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                                'By signing up you acknowledge that you have read the ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = followLink,
                          ),
                        ]),
                      );
                    }),
                SizedBox(
                  height: 20,
                ),
                Link(
                  uri: Uri.parse(
                      'https://www.spiralapp.site/terms-and-conditions'),
                  builder: (context, followLink) {
                    return RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text: ' and agree to the ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'Terms of Use',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = followLink,
                        ),
                      ]),
                    );
                  },
                ),
              ],
            ),
          ),
          top: false,
        ),
      );
}
