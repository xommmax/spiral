import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/auth/onboarding/onboarding_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:stacked/stacked.dart';

class OnboardingViewContent extends ViewModelWidget<OnboardingViewModel> {
  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
    return IntroductionScreen(
      pages: viewModel.pages,
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.navigate_next),
      onDone: viewModel.onDonePressed,
      dotsDecorator: DotsDecorator(
        activeColor: AppColors.lightestAccentColor,
        color: AppColors.lightGray.withOpacity(0.8),
      ),
      color: AppColors.lightestAccentColor,
      // color: AppColors.white,
    );
  }
}
