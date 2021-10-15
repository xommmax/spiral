import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/auth/details/auth_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class AuthDetailsViewContent extends ViewModelWidget<AuthDetailsViewModel> {
  @override
  Widget build(BuildContext context, AuthDetailsViewModel viewModel) {
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
            child: Column(
              children: [
                Text("AAAA"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
