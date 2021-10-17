import 'package:dairo/app/locator.dart';
import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/tools/shared_pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OnboardingViewModel extends BaseViewModel {
  final List<PageViewModel> pages;
  final NavigationService _navigationService = locator<NavigationService>();

  OnboardingViewModel()
      : pages = [
          PageViewModel(
            title: "Showcase your lifestyle",
            body:
                "Share your life, hobbies and interests using unlimited themed rubrics called hubs",
            image: Center(
              child: SvgPicture.asset(
                "assets/images/onboarding/showcase.svg",
                height: 175.0,
              ),
            ),
          ),
          PageViewModel(
            title: "Untie your hands",
            body:
                "Create everything you want. Add media, text, links, files - whatever you like",
            image: Center(
              child: SvgPicture.asset(
                "assets/images/onboarding/constructor.svg",
                height: 175.0,
              ),
            ),
          ),
          PageViewModel(
            title: "Custom follow",
            body:
                "Watch and the only things you like. Follow user hubs separately and personalise your interests",
            image: Center(
              child: SvgPicture.asset(
                "assets/images/onboarding/custom_follow.svg",
                height: 175.0,
              ),
            ),
          ),
          PageViewModel(
            title: "Discuss your interests",
            body:
                "Interact and discuss favourite topics with like-minded users in chosen hub",
            image: Center(
              child: SvgPicture.asset(
                "assets/images/onboarding/discuss.svg",
                height: 175.0,
              ),
            ),
          ),
        ];

  void onDonePressed() async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.setBool(
        SharedPreferencesKeys.isOnboardingCompleted, true);

    _navigationService.clearStackAndShow(Routes.authSplashView);
  }
}
