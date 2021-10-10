import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/settings/settings_viewmodel.dart';
import 'package:dairo/presentation/view/settings/widgets/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class ProfileSettingsViewContent
    extends ViewModelWidget<ProfileSettingsViewModel> {
  @override
  Widget build(BuildContext context, ProfileSettingsViewModel viewModel) =>
      Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.settings,
            style: TextStyles.toolbarTitle,
          ),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                WidgetSettingsItem(
                  text: Strings.contact,
                  onItemClicked: viewModel.onContactItemClicked,
                ),
                WidgetSettingsItem(
                  text: Strings.blockedUsers,
                  onItemClicked: viewModel.onBlockedUsersItemClicked,
                ),
                WidgetSettingsItem(
                  text: Strings.account,
                  onItemClicked: viewModel.onAccountItemClicked,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 24,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      child: Text(Strings.terms,
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.white,
                          )),
                      onTap: viewModel.onTermsClicked,
                    ),
                    SizedBox(width: 36),
                    InkWell(
                      child: Text(Strings.privacy,
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.white,
                          )),
                      onTap: viewModel.onPrivacyClicked,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
