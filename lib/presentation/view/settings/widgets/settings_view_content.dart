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
        body: ListView(
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
      );
}
