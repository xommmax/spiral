import 'package:dairo/presentation/view/base/loading_widget.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_list_item.dart';
import 'package:dairo/presentation/view/hubs/hubs_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetHubsList extends ViewModelWidget<HubsViewModel> {
  @override
  Widget build(BuildContext context, HubsViewModel viewModel) =>
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
