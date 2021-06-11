import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/auth/auth_viewmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class ButtonSignUp extends ViewModelWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context, AuthViewModel viewModel) =>
      GestureDetector(
        onTap: viewModel.onSignUpClicked,
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
              Strings.signup,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      );
}
