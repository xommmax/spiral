import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/settings/contact/settings_contact_viewmodel.dart';
import 'package:dairo/presentation/view/settings/widgets/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class SettingsContactViewContent
    extends ViewModelWidget<SettingsContactViewModel> {
  @override
  Widget build(BuildContext context, SettingsContactViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.contact,
          style: TextStyles.toolbarTitle,
        ),
      ),
      body: ListView(
        children: [
          WidgetSettingsItem(
            text: Strings.support,
            onItemClicked: viewModel.onSupportItemClicked,
          ),
          WidgetSettingsItem(
            text: Strings.reportBug,
            onItemClicked: viewModel.onReportBugItemClicked,
          ),
          WidgetSettingsItem(
            text: Strings.suggestImprovement,
            onItemClicked: viewModel.onImprovementItemClicked,
          ),
        ],
      ),
    );
  }
}
