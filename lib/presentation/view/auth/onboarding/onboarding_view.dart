import 'package:dairo/app/router.router.dart';
import 'package:dairo/presentation/view/auth/onboarding/onboarding_view_content.dart';
import 'package:dairo/presentation/view/auth/onboarding/onboarding_viewmodel.dart';
import 'package:dairo/presentation/view/base/standard_base_view.dart';
import 'package:flutter/widgets.dart';

class OnboardingView extends StandardBaseView<OnboardingViewModel> {
  OnboardingView()
      : super(OnboardingViewModel(), routeName: Routes.onboardingView);

  @override
  Widget getContent(BuildContext context) => OnboardingViewContent();
}
