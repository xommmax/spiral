import 'package:dairo/presentation/res/colors.dart';
import 'package:dairo/presentation/view/base/loading_widget.dart';
import 'package:dairo/presentation/view/hub/widgets/widget_hub_header.dart';
import 'package:dairo/presentation/view/publication/publication_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../hub_viewmodel.dart';

class WidgetHubViewContent extends ViewModelWidget<HubViewModel> {
  @override
  Widget build(BuildContext context, HubViewModel viewModel) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: viewModel.isDataReady()
                ? Column(
                    children: [
                      WidgetHubHeader(),
                      WidgetHubList(),
                    ],
                  )
                : ProgressBar(
                    alignment: ProgressBarAlignment.Center,
                  ),
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

class WidgetHubList extends ViewModelWidget<HubViewModel> {
  @override
  Widget build(BuildContext context, HubViewModel viewModel) =>
      ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, position) {
          final publicationId = viewModel.viewData.publicationIds[position];
          return PublicationView(
            publicationId,
            isPreview: true,
          );
        },
        separatorBuilder: (context, position) => Divider(height: 14),
        itemCount: viewModel.viewData.publicationIds.length,
      );
}
