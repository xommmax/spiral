import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/settings/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetSettingsContent extends ViewModelWidget<SettingsViewModel> {
  @override
  Widget build(BuildContext context, SettingsViewModel viewModel) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Strings.settings,
            style: TextStyles.white22Bold,
          ),
          actions: [
            IconButton(
              onPressed: viewModel.onLogoutClicked,
              icon: Icon(
                Icons.logout,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        body: ListView.separated(
          itemCount: viewModel.viewData.settingsItems.length,
          itemBuilder: (context, index) => Column(
            children: [
              index == 0
                  ? Divider(
                      height: 1,
                      color: AppColors.primaryColor,
                    )
                  : SizedBox.shrink(),
              _WidgetSettingsItem(
                text: viewModel.viewData.settingsItems[index],
                index: index,
                onItemClicked: viewModel.onItemClicked,
              ),
              index + 1 == viewModel.viewData.settingsItems.length
                  ? Divider(
                      height: 1,
                      color: AppColors.primaryColor,
                    )
                  : SizedBox.shrink(),
            ],
          ),
          separatorBuilder: (context, index) => Divider(
            height: 1,
            color: AppColors.primaryColor,
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
          padding: EdgeInsets.fromLTRB(8, 24, 8, 24),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: TextStyles.primary16,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.primaryColor,
              )
            ],
          ),
        ),
      );
}
