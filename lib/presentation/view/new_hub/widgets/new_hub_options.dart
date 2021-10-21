import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/new_hub/new_hub_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NewHubOptionsWidget extends ViewModelWidget<NewHubViewModel> {
  @override
  Widget build(BuildContext context, NewHubViewModel viewModel) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "Select options:",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24),
          child: Row(
            children: [
              Switch(
                value: viewModel.isPrivate,
                onChanged: viewModel.onPrivateSwitchChanged,
                activeColor: AppColors.lightestAccentColor,
              ),
              SizedBox(width: 16),
              Text(
                Strings.private,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24),
          child: Row(
            children: [
              Switch(
                value: viewModel.isDiscussionEnabled,
                onChanged: viewModel.onDiscussionSwitchChanged,
                activeColor: AppColors.lightestAccentColor,
              ),
              SizedBox(width: 16),
              Text(
                Strings.discussion,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ]);
}
