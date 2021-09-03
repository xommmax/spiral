import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/profile/base/base_profile_viewmodel.dart';
import 'package:dairo/presentation/view/profile/base/widgets/widget_hub_preview.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetHubGrid<T extends BaseProfileViewModel> extends ViewModelWidget<T> {
  @override
  Widget build(BuildContext context, T viewModel) {
    final hubs = viewModel.viewData.hubs;
    if (hubs.isEmpty) return _buildEmptyState();
    return _buildGrid(viewModel);
  }

  _buildGrid(T viewModel) => Flexible(
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          childAspectRatio: 16 / 13,
          children: viewModel.viewData.hubs
              .map(
                (hub) => InkWell(
                  onTap: () => viewModel.onOpenHubClicked(hub),
                  child: WidgetHubPreview(hub),
                ),
              )
              .toList(),
        ),
      );

  _buildEmptyState() => Text(Strings.no_hubs);
}
