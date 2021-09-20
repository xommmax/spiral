import 'package:dairo/presentation/view/base/loading_widget.dart';
import 'package:dairo/presentation/view/followings/followings_viewmodel.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetFollowingsList extends ViewModelWidget<FollowingsViewModel> {
  @override
  Widget build(BuildContext context, FollowingsViewModel viewModel) =>
      viewModel.dataReady
          ? ListView.separated(
              itemBuilder: (context, index) => WidgetHubListItem(
                viewModel.data![index],
                onOpenHubDetailsClicked: viewModel.onOpenHubDetailsClicked,
              ),
              separatorBuilder: (context, index) => Divider(
                height: 10,
              ),
              itemCount: viewModel.data!.length,
            )
          : ProgressBar(
              alignment: ProgressBarAlignment.Center,
            );
}
