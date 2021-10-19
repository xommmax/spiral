import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/settings/account/settings_account_viewmodel.dart';
import 'package:dairo/presentation/view/settings/widgets/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class SettingsAccountViewContent
    extends ViewModelWidget<SettingsAccountViewModel> {
  @override
  Widget build(BuildContext context, SettingsAccountViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.account,
          style: TextStyles.toolbarTitle,
        ),
      ),
      body: ListView(
        children: [
          WidgetSettingsItem(
            text: Strings.logout,
            onItemClicked: viewModel.onLogoutClicked,
          ),
          WidgetSettingsItem(
            text: Strings.deleteAccount,
            onItemClicked: viewModel.onDeleteAccountClicked,
          ),
        ],
      ),
    );
  }
}
