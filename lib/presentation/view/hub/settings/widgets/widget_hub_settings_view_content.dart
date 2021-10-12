import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/hub/settings/hub_settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetHubSettingsContent extends ViewModelWidget<HubSettingsViewModel> {
  @override
  Widget build(BuildContext context, HubSettingsViewModel viewModel) =>
      Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.settings,
            style: TextStyles.toolbarTitle,
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(24, 12, 8, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      Strings.privateHub,
                      style: TextStyle(color: AppColors.white, fontSize: 15),
                    ),
                  ),
                  Switch(
                    value: viewModel.viewData.hub.isPrivate,
                    onChanged: viewModel.onPrivateHubSwitchChanged,
                    activeColor: AppColors.lightestAccentColor,
                  )
                ],
              ),
            ),
            Divider(
              height: 1,
              color: AppColors.gray,
            ),
            InkWell(
              onTap: viewModel.onDeleteHubClicked,
              child: Container(
                padding: EdgeInsets.fromLTRB(24, 24, 8, 24),
                alignment: Alignment.centerLeft,
                child: Text(
                  Strings.deleteHub,
                  style: TextStyle(color: Colors.red, fontSize: 15),
                ),
              ),
            ),
            Divider(
              height: 1,
              color: AppColors.gray,
            ),
          ],
        ),
      );
}
