import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/base/loading_widget.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_header.dart';
import 'package:dairo/presentation/view/publication/widgets/publication_list.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../hub_viewmodel.dart';

class WidgetHubViewContent extends ViewModelWidget<HubViewModel> {
  @override
  Widget build(BuildContext context, HubViewModel viewModel) {
    if (!viewModel.isDataReady()) {
      return ProgressBar(alignment: ProgressBarAlignment.Center);
    }

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: viewModel.scrollController,
          slivers: [
            WidgetHubHeader(),
            SliverToBoxAdapter(child: _HubDescriptionWidget()),
            PublicationListView(viewModel.viewData.publicationIds),
          ],
        ),
      ),
      floatingActionButton: (viewModel.viewData.hub != null &&
              viewModel.viewData.hub!.isDiscussionEnabled)
          ? FloatingActionButton(
              onPressed: viewModel.onFabPressed,
              child: Icon(
                Icons.message_outlined,
                color: AppColors.white,
              ),
              backgroundColor: AppColors.darkestGray,
            )
          : null,
    );
  }
}

class _HubDescriptionWidget extends ViewModelWidget<HubViewModel> {
  @override
  Widget build(BuildContext context, HubViewModel viewModel) {
    if (viewModel.viewData.hub?.description == null) {
      return SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Text(
            viewModel.viewData.hub!.description!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.lightGray,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Divider(
          height: 1,
          indent: 8,
          endIndent: 8,
          color: AppColors.lightGray,
        ),
      ],
    );
  }
}
