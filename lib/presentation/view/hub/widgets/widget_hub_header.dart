import 'package:cached_network_image/cached_network_image.dart';
import 'package:dairo/presentation/res/text_styles.dart';
import 'package:dairo/presentation/view/hub/hub_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class WidgetHubHeader extends ViewModelWidget<HubViewModel> {
  @override
  Widget build(BuildContext context, HubViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: viewModel.hub.pictureUrl,
            height: 212,
            width: double.maxFinite,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              viewModel.hub.description,
              style: TextStyles.black14,
            ),
          ),
        ],
      );
}
