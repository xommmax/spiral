import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/profile/base/base_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetBaseProfileHubGrid<T extends BaseProfileViewModel>
    extends ViewModelWidget<T> {
  @override
  Widget build(BuildContext context, T viewModel) {
    if (viewModel.hubList == null) return _buildLoadingState();
    if (viewModel.hubList!.isEmpty) return _buildEmptyState();
    return _buildGrid(viewModel);
  }

  _buildGrid(BaseProfileViewModel viewModel) => Flexible(
        child: GridView.count(
          crossAxisCount: 2,
          children: viewModel.hubList!.map((hub) {
            return Column(
              children: [
                CachedNetworkImage(
                  imageUrl: hub.pictureUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Text(hub.name),
              ],
            );
          }).toList(),
        ),
      );

  _buildLoadingState() => CircularProgressIndicator();

  _buildEmptyState() => Text(Strings.no_hubs);
}
