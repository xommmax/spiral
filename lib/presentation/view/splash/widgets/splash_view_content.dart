import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/splash/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetSplashViewContent extends ViewModelWidget<SplashViewModel> {
  @override
  Widget build(BuildContext context, SplashViewModel viewModel) => Scaffold(
        body: SafeArea(
          child: viewModel.data?.user == null
              ? SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        viewModel.data?.user?.phoneNumber != null
                            ? 'User registered using phone number:\n${viewModel.data?.user?.phoneNumber}'
                            : 'User registered using email: ${viewModel.data?.user?.email}',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 24),
                      ),
                      GestureDetector(
                        onTap: viewModel.onResetUserClicked,
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          height: 36,
                          margin: EdgeInsets.only(top: 24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primaryColor,
                          ),
                          child: Center(
                            child: Text(
                              'Remove user',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      );
}
