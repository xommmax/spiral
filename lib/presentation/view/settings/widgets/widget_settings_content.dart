import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/settings/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetProfileSettingsContent
    extends ViewModelWidget<ProfileSettingsViewModel> {
  @override
  Widget build(BuildContext context, ProfileSettingsViewModel viewModel) =>
      Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.settings,
            style: TextStyles.toolbarTitle,
          ),
          actions: [
            IconButton(
              onPressed: viewModel.onLogoutClicked,
              icon: Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
        body: ListView.separated(
          itemCount: viewModel.viewData.settingsItems.length,
          itemBuilder: (context, index) => Column(
            children: [
              _WidgetSettingsItem(
                text: viewModel.viewData.settingsItems[index],
                index: index,
                onItemClicked: viewModel.onItemClicked,
              ),
              index + 1 == viewModel.viewData.settingsItems.length
                  ? Divider(
                      height: 1,
                      color: AppColors.gray,
                    )
                  : SizedBox.shrink(),
            ],
          ),
          separatorBuilder: (context, index) => Divider(
            height: 1,
            color: AppColors.gray,
          ),
        ),
      );
}

class _WidgetSettingsItem extends StatelessWidget {
  final String text;
  final int index;
  final Function(int) onItemClicked;

  _WidgetSettingsItem({
    required this.text,
    required this.index,
    required this.onItemClicked,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => onItemClicked(index),
        child: Container(
          padding: EdgeInsets.fromLTRB(24, 24, 8, 24),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(color: AppColors.black, fontSize: 15),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.black,
              )
            ],
          ),
        ),
      );
}
