import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/presentation/res/strings.dart';
import 'package:dairo/presentation/view/profile/base/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WidgetProfileHubGrid extends ViewModelWidget<ProfileViewModel> {
  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    if (viewModel.hubList == null) return _buildLoadingState();
    if (viewModel.hubList!.isEmpty) return _buildEmptyState();
    return _buildGrid(viewModel);
  }

  _buildGrid(ProfileViewModel viewModel) => Flexible(
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
