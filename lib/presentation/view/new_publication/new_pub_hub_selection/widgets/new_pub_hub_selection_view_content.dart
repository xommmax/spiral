import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_list_item.dart';
import 'package:dairo/presentation/view/new_publication/new_pub_hub_selection/new_pub_hub_selection_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class NewPubHubSelectionViewContent
    extends ViewModelWidget<NewPubHubSelectionViewModel> {
  @override
  Widget build(BuildContext context, NewPubHubSelectionViewModel viewModel) =>
      Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.postTo,
            style: TextStyles.toolbarTitle,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              itemCount:
                  (viewModel.data != null) ? viewModel.data!.length + 1 : 0,
              itemBuilder: (context, index) {
                if (index == viewModel.data!.length) return _CreateNewHub();
                return WidgetHubListItem(viewModel.data![index],
                    onOpenHubDetailsClicked: (hub) =>
                        viewModel.onHubSelected(hub));
              },
            ),
          ),
        ),
      );
}

class _CreateNewHub extends ViewModelWidget<NewPubHubSelectionViewModel> {
  @override
  Widget build(BuildContext context, NewPubHubSelectionViewModel viewModel) =>
      ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.gray),
          ),
          child: Center(
            child: Text('+',
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.darkGray,
                )),
          ),
        ),
        title: Text(
          Strings.newHub,
          style: TextStyle(
            color: AppColors.darkGray,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: viewModel.onCreateHub,
      );
}
