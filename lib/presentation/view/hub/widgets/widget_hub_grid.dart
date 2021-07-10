import 'package:dairo/domain/model/hub/hub.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_preview.dart';
import 'package:dairo/presentation/view/profile/base/base_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetHubGrid<T extends BaseProfileViewModel> extends ViewModelWidget<T> {
  @override
  Widget build(BuildContext context, T viewModel) {
    final hubList = viewModel.hubList;
    if (hubList == null) return _buildLoadingState();
    if (hubList.isEmpty) return _buildEmptyState();
    return _buildGrid(hubList);
  }

  _buildGrid(List<Hub> hubList) => Flexible(
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          childAspectRatio: 16 / 13,
          children: hubList.map((hub) => WidgetHubPreview(hub)).toList(),
        ),
      );

  _buildLoadingState() => CircularProgressIndicator();

  _buildEmptyState() => Text(Strings.no_hubs);
}
