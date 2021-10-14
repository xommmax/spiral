import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/auth/splash/auth_splash_viewmodel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthSplashViewContent extends ViewModelWidget<AuthSplashViewModel> {
  @override
  Widget build(BuildContext context, AuthSplashViewModel viewModel) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.darkAccentColor,
                AppColors.lightAccentColor,
              ],
            ),
          ),
          child: Center(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: ColorFiltered(
                      colorFilter:
                          ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                      child: Image.asset(
                        'assets/images/spiral_home_logo.png',
                        width: 50,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 80),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                        SizedBox(height: 24),
                        Text(
                          "turn your personality and interests\ninto something more significant",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: AppColors.lightGray,
                            fontFamily: 'Sofia-Pro',
                            height: 1.375,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: viewModel.onGetStartedPressed,
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.darkAccentColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.lightGray),
                            minimumSize: MaterialStateProperty.all(
                                Size(double.infinity, 56)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36.0),
                            ))),
                      ),
                      _bottomLinks(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomLinks() => Padding(
        padding: EdgeInsets.all(16),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
              text: 'By tapping on "Get Started", you agree to our \n',
              style: TextStyle(
                color: AppColors.lightGray,
                fontSize: 14.5,
              ),
            ),
            TextSpan(
              text: 'Terms of Use',
              style: TextStyle(
                color: AppColors.lightGray,
                fontWeight: FontWeight.w900,
                fontSize: 14.5,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch(Strings.termsUrl),
            ),
            TextSpan(
              text: ' and ',
              style: TextStyle(
                color: AppColors.lightGray,
                fontSize: 14.5,
              ),
            ),
            TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(
                color: AppColors.lightGray,
                fontWeight: FontWeight.w900,
                fontSize: 14.5,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch(Strings.privacyUrl),
            ),
          ]),
        ),
      );
}
